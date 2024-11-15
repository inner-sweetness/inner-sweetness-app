import 'package:medito/models/article/article_model.dart';
import 'package:medito/services/network/dio_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'articles_repository.g.dart';

abstract class ArticleRepository {
  Future<ArticleModel> fetchArticles(String articleId);
}

class ArticleRepositoryImpl extends ArticleRepository {
  final DioApiService client;

  ArticleRepositoryImpl({required this.client});

  @override
  Future<ArticleModel> fetchArticles(String articleId) async {
    return const ArticleModel(
      id: 'article-model-1',
      title: 'Tale as old as time',
      subTitle: 'Inner Conflict Vs Inner Sweetness',
      description: '''
When we feel our worst we tend to say:  ̈I don't feel like myself ́ today.
It usually happens if we are experiencing disatisfaction, anger, sadness or a sense of unfulfillment.
Have you noticed?
It's clear that when you are feeling content: you feel pretty much like yourself.
And that's no coincidence. This is in everyone's experience and is true.
But why?
It's because:  ̈feeling good ̈ inside or content is your true inherent nature.
Or what we call Inner Sweetness.
And when you don't feel this good inside you just don't feel like yourself. And you resent it or hate it. So then you go do something to try to get some artificial  ̈goodness inside ̈ like drinking or shopping. Or you take a pill to avoid the fact you don't feel sweet enough to just go to sleep easily like your dog does.
Why aren't you feeling good or content most of the time if we say is your true inherent nature?
That is the Tale as Old as Time.
Because this  ̈not feeling good inside ̈ started happening progressively when you started solidifying your sense of time. Which you didn't have very much when you were a small kid.
 
 When you were a small kid you were naturally content:
All of this characteristics where a part of you:
Creative Flexible Joyful
More relaxed
This is what
And it was a
fantastic. Unless your parents wanted you to behave which made you feel uncomfortable because you were loving everything and taking it all in, sometimes literally, sticking a shoe in your mouth.
As a kid you had a natural devotion to be wherever you were.
And most importantly: you didn ́t need anything different from you to create this inner good feeling inside. No outside help. It was just natural to you.
So what happened?
You developed an image about yourself as you growed up.
And that Inner Image craves and needs value: ALWAYS. And it's very easy for that Inner Image to demonstrate in any situation how it doesn't have any or very little value. The Inner Image is always unfulfilled. And it makes you  ̈act out ̈. That's why it is a bit exhausting seeing people because always something is at stake and that is: the Inner Image's value. Or in other words how I need the other to perceive I have value. It's exhausting.
The image is truly a construct in what you call your mind. Formless.
Conceptual.
Thought made.
It's truly an image because if I say to you that you are stupid and it hurts, your elbow doesn't feel hurt, nor does your knee or your eyes or your sense of smell. What is it really getting hurt? Because it is not your body.
we call Inner Sweetness.
consequence of JUST BEING. Being wherever you were was

 It is the Inner Image. What you think about yourself. What you believe you are or you are not.
It has no reality at all because it also changes over time. The image is not inherent to you. But you think it is.
And that image needs to know: it has value.
If you were a kid and someone would ask you: what value do you have to feel so content? The kid would not even understand what something called value is needed for him to feel good inside. That's because the kid has not yet solidified an Inner Image that requires validation in any way. The same way your cat doesn't have any.
So please see very clearly that this Inner Image is not natural to you. You didn ́t came with it. It is not real because it is imaginary or conceptual. And that the trouble maker or the producer of Inner Conflict in you is always: the Inner image.
In other words: the need to know my value at all times is the source of Inner Conflict.
So it goes like this.
The Inner Image craves value because it doesn't know if it has it or if it will ever have it. This produces Inner Conflict
And Inner Conflict creates NE-motions. Yes. NE-Motions. Not your regular word. We know. We ́ll explain later.
NE-motions create the  ̈not feeling good inside or  ̈not feeling like myself ̈.
NOW.
This follows.
It might sound weird so just humor us for a second.
In the absence of negative energy within you or NE-motions you just feel good. You just feel like your lovely dog or cat. Just like any animal in nature that does not experience Inner Conflict (not as much as we do) because they don ́t have an image about themselves. NE-motions are mostly human

 A tiger is always a fantastic tiger. No need for any validation or notion of the value he has. That is why we are so amazed by watching them. They are so full of themselves, like kids are, and we love to see them. We sense we lack that serenity and content they seem to so naturally have.
And that is also true.
SO. The negativity here is called NE-motions because we are separating them from the emotions you commonly know. And they actually are negative energy in motion.
NE-motions are:
Anxiety Unfulfillment Disappointment Resentment
And now it gets good because if you look closely you will see ALL of them come from what we call The Inner Image ́s Fear of not having value.
Anxiety happens when the Inner Image ́s fears its value being at risk. Unfulfillment happens when the Inner Image ́s fears nothing it has is of value.
Disappointment happens when the Inner Image ́s fears it has lost its value.
Resentment happens when the Inner Image ́s fears others didn ́t see the value it has.
Anxiety can lead to anger or sadness Unfulfillment can lead to anger or sadness Disappointment can lead to anger or sadness Resentment can lead to anger or sadness.
But FEAR is always the BASE
We will cover later on Raw Sadness and Raw Fear. Because those are of a different nature. For example the Raw Fear of a lion in front of me right now. That has no Inner Image. Is just instant row fear. See the difference? Any animal with no brain senses this. That ́s why we call it raw.

Coming back.
Any NE-motion is very different from the experience of Inner Sweetness or content. We don't want to say Inner Sweetness is positive because it has no opposite is just what IS naturally left when NE-motions are not around anymore.
Like you were as a kid.
We are pretty much capable of experiencing or having a great deal of Ne-emotions but experiencing something or having it does not mean it is natural to you. Because the image (a conceptual construct) is not necessary for you to live. Is it?
So it is not so much that you need to change your energies from negative to positive. Is just that when NE-motions are out, your natural content or sweetness just IS. And then suddenly, your sense of time collapses a bit. You are naturally more  ̈present ̈now. Because when the Inner Image was created your sense of Inner Conflict started immediately and NE-Motions are just a consequence.
Inner Conflict is unnatural to you, as is the image. Inner Sweetness is your true nature.
      ''',
      coverUrl: '',
      isPublished: false,
    );
    // var response = await client.getRequest('${HTTPConstants.packs}/$packId');
    // return ArticleModel.fromJson(response);
  }
}

@Riverpod(keepAlive: true)
ArticleRepositoryImpl articleRepository(ArticleRepositoryRef _) {
  return ArticleRepositoryImpl(client: DioApiService());
}
