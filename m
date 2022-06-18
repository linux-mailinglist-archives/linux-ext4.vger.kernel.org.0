Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E43550758
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiFRW02 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiFRW01 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 18:26:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602510FFD
        for <linux-ext4@vger.kernel.org>; Sat, 18 Jun 2022 15:26:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w2so4841978lji.5
        for <linux-ext4@vger.kernel.org>; Sat, 18 Jun 2022 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UkGKIQ2Fz3FlPB0gALzPKo7MIdVSW8NxlsmZ7RXA/G8=;
        b=NXktq7aMFE5/4rs4l+iaNKyA1T8uWZ9c26MzVxpzXCkeF5KnmTq/ZEXlKOgJU2ftMi
         a8Cc9NFWsf1NOCtRbA/QMTmIMaRRR7ogP1SlnoUSnXvYflhZyVF9KJ4CnamQHeAiqWux
         PG75bhrMYjNyZobtL42b4B2o9V0lN0f197kkTq2YQur4rD/y/aBUJ8tu34Ujc8kcUP1w
         oYJy9p5FVn33TZdqaqnPZ4Qttsc6qOiEsFWTEWScoa2uIxzUfkdgUIOSRNy7U2CyyjD4
         ahZm+kDjltNDvcCNmRMNUN7czMKHz5qR02uFB4upeP0imlAXSZXn73dF0HmOV4c2GhNv
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UkGKIQ2Fz3FlPB0gALzPKo7MIdVSW8NxlsmZ7RXA/G8=;
        b=VL8eCU8eZXZjtUkAhYtx2OTFH1ZIKEPFD6+Fa4iKqcoKziWw9Eagfm02WZC701XIg3
         SztZ0e5kw/+s2EiCYzeYWHRljCwyLVsBQPfIawtlNFsnT98ArqT2hhS5QErze+WNfS5d
         bvmIVG6cCZIdepFk/g/pjr38PFSSIiy5Aterm/VLeaU7S2sXfhBCn49DHV1YXzItiIs/
         j1VyEZy72EC1/81z8HBehvxvvQpOlh0H8SWQmhBxf3iLdQq6aFig8jKX2DUxcIjumJWM
         2PK/0bX+kbEJcpGWNDIUKLJy+X2c5K9xYOFYYRK8q0hbsVQM8KsfPZ66onDgySfF12Ei
         INew==
X-Gm-Message-State: AJIora8ToGFWUqcsg936U2u7AwdgJKBdY9gcLauZ6e6Qdg43zJ/izDdb
        jQeHxI2v6y0BJTEi5m5F5l0pidSQBgc//8OEwbU=
X-Google-Smtp-Source: AGRyM1ugcEFXt52ZdFZuFf3cTLYHgc/zkcCP6GOYpJxmm1yv7QNa8u/mR3UJujK0uH+FggLOnrdi3a5qdReJ24Weo1o=
X-Received: by 2002:a2e:80d3:0:b0:255:5c62:7614 with SMTP id
 r19-20020a2e80d3000000b002555c627614mr8218352ljg.389.1655591184632; Sat, 18
 Jun 2022 15:26:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3e0b:0:0:0:0 with HTTP; Sat, 18 Jun 2022 15:26:23
 -0700 (PDT)
Reply-To: krf1470@gmail.com
From:   Gilbert Hassan <fazzabinprince28@gmail.com>
Date:   Sat, 18 Jun 2022 23:26:23 +0100
Message-ID: <CALTDPuP5RjGegM-jyjYcguqwW9K_Ok41qRbV4BiDs-vVbMOMWw@mail.gmail.com>
Subject: A Representative for Service to Humanity Needed!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [krf1470[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fazzabinprince28[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fazzabinprince28[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Attn:


May the love and peace of the Almighty Allah be with you and your
family.  My name  is Gilbert Hassan, a representative (Financial
adviser) of Sheikh Hamdan bin Mohammed bin Rashid Al Maktoum (Fazza),
Founder and owner of Al Maktoum Foundation.


Can we seek your consent in establishing charity foundation, work and
organization and investment with the funds that my client has mapped
out for charity work which is deposited in a security firm/bank.


We have embark in charity work, thereby giving back to the society,
which  is service to humanity and the best work of life.


Now, we are looking for a reputable, reliable and God fearing person
Whom we can entrust as an agent/ambassador to help us to establish a
Charity/orphanage home in your country in other  to enhance the lives
of the poor, less privileged and also fight Covid-19 (Corona Virus).


In your interest, do get back to us for more details.


Looking forward to hearing from you.


Regards,
Gilbert Hassan.
