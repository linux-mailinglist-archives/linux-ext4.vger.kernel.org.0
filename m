Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A489546A69
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jun 2022 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiFJQcu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jun 2022 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbiFJQct (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jun 2022 12:32:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D14856B16
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jun 2022 09:32:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v22so47868237ybd.5
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jun 2022 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=YGb7T13IJ8UiqfUJsmv02nu9YXnSJcbAUt/Mw1b+6ond6Dc2qqxiyORhyo3av0M89s
         9OcHBOtfbbrRc9cquT7RcjEQpvQa8VVX8YZOZj7QBiGS2dsajxO5Y/+BsgU+M7MgPMiM
         pKT7ohn/HbmAeM6/yxR+dSbQSZEx3cImo7f4ikdZC0NhAAKeGRRcvpe5I6I5qjkdYfjp
         ALRdVMVwT08KL5DBr4wUVfSvPEv4IIladqD1EdLJ+Iy9c7POvAZJwvM29n4D6Zxx7iMg
         WRafBNmnTTDXsUKpZ+d+XQOE55IB1JLiIrAoQ1+Tt6YxeDtP/dG/SdhUVnHCwkkKT+Tm
         Fm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=0XYuJwlWcPhF5wKwZj6AX0M1ehVlcZ8wjqHIDg46ZGY=;
        b=IfzcL25aXr2eveD6YXuND3xkRf8F9fMs+O1OMR18VScAkuy/anfl7yUvLw/KyDmDKr
         i+cQAx4EG6TZBMrWgA0HvBYhYUkk3ReYD1a5lHvP15H3wAk+uav6H6Hel4zHsgxCZx1i
         b4MZh/ER1MJbyMf+l9bJIkGrNamoX9DtTFyY/wssPk3riR/7S0NT926+zZcqxJ99t1/w
         i7s1crK8WOb5Orlt984uDV64oTkbZ7ZwkUF8gAQXpMW8HO/+8fM7M5Mt0IVNl9p8jTyR
         ab6edQwloAWTisfli18mar5e265optBUfAMlfCd7i2EsKZl80P3AUKw6/EKnncrchD/x
         yprQ==
X-Gm-Message-State: AOAM531CR9rcUS2ExHDoJw69YNJiBMc9vAotGkChxjgBcg9X9dUwJ5QK
        pxbXepQx0+Q11bURXAV3l0hsFSjE680I9fY5sZY=
X-Google-Smtp-Source: ABdhPJwax1n8gVqAuKV+ceFuVHBEqDyXMZ25+fmnz7g3HqM17F6VLNri5lzclLDgJw8R7/qGGvkPhTKWnw5QPNso4k4=
X-Received: by 2002:a5b:b:0:b0:663:f6b5:e66b with SMTP id a11-20020a5b000b000000b00663f6b5e66bmr14723467ybp.400.1654878765503;
 Fri, 10 Jun 2022 09:32:45 -0700 (PDT)
MIME-Version: 1.0
Sender: adonald323@gmail.com
Received: by 2002:a05:7000:8b10:0:0:0:0 with HTTP; Fri, 10 Jun 2022 09:32:45
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Fri, 10 Jun 2022 16:32:45 +0000
X-Google-Sender-Auth: 7HtA3KAngftg8fKmIq7ATJwMLxs
Message-ID: <CANHbP4O3ktPBLC5xwxvY+_Si8KuoUkpzj-spjV6P6JZeHKWDEw@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9526]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [adonald323[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley. Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Howley. Mckenna.
