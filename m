Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CDD66689D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjALB43 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 20:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjALB41 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 20:56:27 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237043E74
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 17:56:25 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so26319396lfr.3
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmSSbhhEhNXEW3W9t9w57o8kVWicTJWsxS0oppOhO+s=;
        b=Nbfb+cc6/Jv8uOfSRIXbcvEYNftu1RWxauyPQCN50qH13eyuW51VCAu3T5y00xDlVs
         ok1GmT8KQorKaDqwb0Cmf//OxgREB27UKYSlAe2+AXelj15DxJ57EPsyh6RurmPN0xOn
         8u3f2IP8m9d7S1Tz+U273fxixfLxbfNaX8b+AGOB36LZMg5Mxgcz6/u+Mze29i5iTcp6
         81fJfDZS6VLiP8i3MvGJLyVUm2fE4J8a7STYxR7eceJAwZtpIgMjZN3nHJ1iJhRKeYex
         sv0Lj1cCaYxYCChOJ0pYi+LKE334LlyqDYGqC+Q1oegM/ChGzPoCsWSvAt7qC1Y8nQsb
         OEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmSSbhhEhNXEW3W9t9w57o8kVWicTJWsxS0oppOhO+s=;
        b=VcmMfmkjT1xNv+vDKXPmbRj6OUQt+JFOBgxQsOq5UeNetkVvKO7wtREi0qavRshsgM
         NOQVVeekTdU7eltTq3/5ybAJ6eCjk6JtFqHw8GPontxjFO1BPKnoS6YWnh5atoaIB+tL
         EfrzQM9apkJNiiUACQIhmPD1RE2KZ9eZGWrIQsKn2QiJuwEB6YLVJRBv6LRAjmA/Ue9R
         CnanwR+H3aEBBUYpSIdvdmZ1yDvioVOQD9qYRltrTRVFxI7wNT7KAgiqbwMrS55vJ89m
         JTSGPQ+/7a+iTsoSry4M8IMNhjSK865a2lyKSSJY/C9vrmAQNRC/VVoCk0ALqHVzxPvX
         OS6g==
X-Gm-Message-State: AFqh2kpq6IABWU70A84SsiLJp6yo2f3BF+Xnx6AZBGUGrhzoizy3MyOC
        OJ+cKDXLQNNFNBuFA4qrc9/RmQ8618j5pTBqEOg=
X-Google-Smtp-Source: AMrXdXs0qkhm687SxtOGI+OD3mCwNzYEJ0C4zqnHksxr1WqjHTs/27oBNw7z5a60fyCGYQsvnljDDhCpfnLv2e1RN4M=
X-Received: by 2002:a05:6512:1049:b0:4c9:4b8c:4855 with SMTP id
 c9-20020a056512104900b004c94b8c4855mr3023891lfb.462.1673488583614; Wed, 11
 Jan 2023 17:56:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:9c56:0:0:0:0:0 with HTTP; Wed, 11 Jan 2023 17:56:22
 -0800 (PST)
Reply-To: richardwhallo7@gmail.com
From:   Richard Wahl <semeonatuta1968@gmail.com>
Date:   Wed, 11 Jan 2023 13:56:22 -1200
Message-ID: <CADvBfZjjeDnr4Eb-88GoThFc-F26F_aVL25TS4Nw_BXupwXiyA@mail.gmail.com>
Subject: HALLO! antworte schnell auf meine Mail
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5004]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardwhallo7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [semeonatuta1968[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [semeonatuta1968[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.3 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hast du meine Nachricht bekommen, die ich dir geschickt habe? Ihre
E-Mail hat eine Spende von 1.200.000,00 Euro gewonnen und deshalb
sende ich Ihnen Nachrichten. Ignorieren Sie diese Nachricht nicht, da
dies kein Betrug ist. antworten Sie mir dringend f=C3=BCr weitere
Einzelheiten


       Dein Name:
         Dein Land:
         WhatsApp-Nummer:


Ihre Antwort ist erforderlich.
