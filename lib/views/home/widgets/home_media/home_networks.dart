import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medito/views/home/logic/bloc/fetch_network_bloc/fetch_network_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNetworks extends StatelessWidget {
  const HomeNetworks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNetworkBloc, FetchNetworkState>(
      builder: (context, FetchNetworkState state) {
        if (state.isLoading) {
          return const Center(child: SizedBox(height: 24, child: CircularProgressIndicator()));
        } else if (state.hasError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state.isEmpty) {
          return const Center(
            child: Text(
              'No networks found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state.isSuccess) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: state.networks.map((e) => GestureDetector(
              onTap: () => launchUrl(Uri.parse(e.url ?? ''), mode: LaunchMode.externalApplication),
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.network(e.image ?? ''),
            )).toList()
          );
        }
        return const SizedBox();
      },
    );
  }
}
/*
*
* {message: Contentful networks data retrieved successfully., data: [{name: instagram, url: https://www.instagram.com/your-profile, image: http://159.223.195.19:3000/static/icons/instagram.svg}, {name: linkdin, url: https://www.linkedin.com/your-profile, image: http://159.223.195.19:3000/static/icons/linkedin.svg}, {name: spotify, url: https://www.spotify.com/your-profile, image: http://159.223.195.19:3000/static/icons/spotify.svg}, {name: youtube, url: https://www.youtube.com/your-profile, image: http://159.223.195.19:3000/static/icons/youtube.svg}, {name: tiktok, url: https://www.tiktok.com/your-profile, image: http://159.223.195.19:3000/static/icons/tiktok.svg}]}
* */