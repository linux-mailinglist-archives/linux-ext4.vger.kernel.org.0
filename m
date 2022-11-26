Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38F26392E0
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Nov 2022 01:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKZA4M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Nov 2022 19:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZA4L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Nov 2022 19:56:11 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D55985A
        for <linux-ext4@vger.kernel.org>; Fri, 25 Nov 2022 16:56:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v7so4599523wmn.0
        for <linux-ext4@vger.kernel.org>; Fri, 25 Nov 2022 16:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=IBwyrFi2pBgbI7taSBf2wP9AaMzi2odBiSc1JZovbhDndgOpn5eqDyQJr3KydfglqS
         dKppRqfSrbTHg8uEd8Wa8j8pMslFYhgD2n7uYDfu+akpr+gr2cbCVMz92K51VRVI4sLS
         z0eCjQLdCGz9pUDoudFOPI+Gcf/PeWT0sKVsd2yxPt/MXK2msmprpiKTJxnc6A8rMCnQ
         roYmIonOiRPiOxpcztOZrOUsq/+CEoCeIs1F25bI3W+uQQPPG+s/TWFOSkSu/tOgShGc
         /sYjdpUYDqJsqYP8uDfTkyZdpCiIFV6GXfTylNJ4hN+M+XmRH7St1oyX4wJvtfH7ihj3
         ixKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=Z3PWgnHiVjWvEbWnUErbWSFrh1Vkr02xZ8LE57k6aoWrRqyRvixW5BJTtiMPQh6z1g
         ohF9kUqdLWjoIJUM7ZGR21WxiiJrRldBkLxafQPRh527W2nKwkg5nRWQliawxTvP9bJr
         iD3/NM4nkl470KO8T5p+n0zqxqrKzck9T43MnOFUEflF+ouJ35bO3o5fEX1I+c7B+R5N
         IgltITqRcPt/8vMe2zF8uqc41otr2+H3DesvMWXPSRiJBnfUIVUJ44CgFggUo794NR9J
         XnGcXy01ATnVhKcKXwuCGY2WgQvCD8ls7v9gtJktiFPlz7qhpTzMA/bLvA+blIgdm0ez
         hR4Q==
X-Gm-Message-State: ANoB5pnrf0/8VLjFVMaYhAnzbrsXd/QA/EBWTf5PUgOY8mKhz/LhNeRq
        EqvqmS2ijGGmyuc690uWJpYwM1ITGxC8F1YshDo=
X-Google-Smtp-Source: AA0mqf6Jbn2EeTy3eDtJIQBsgeUChdoXCAe8fQW5t2qZyokoEhHGRHXV9Snx9m8FwRJJD78a24lcQdsY8btI5gG2ijU=
X-Received: by 2002:a7b:ca43:0:b0:3cf:ade4:d529 with SMTP id
 m3-20020a7bca43000000b003cfade4d529mr16736724wml.193.1669424168930; Fri, 25
 Nov 2022 16:56:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:d1cf:0:0:0:0:0 with HTTP; Fri, 25 Nov 2022 16:56:08
 -0800 (PST)
Reply-To: samsonvichisunday@gmail.com
From:   Aminu Bello <aminuadamuvitaform@gmail.com>
Date:   Sat, 26 Nov 2022 01:56:08 +0100
Message-ID: <CADwEiStmOu+9QWNSG8dx2E+1gyO0Ob_1gobK7QyovdBwcsx6qQ@mail.gmail.com>
Subject: INVITATION TO THE GREAT ILLUMINATI SOCIETY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_LOAN,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aminuadamuvitaform[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
INVITATION TO THE GREAT ILLUMINATI SOCIETY
CONGRATULATIONS TO YOU....
You have been chosen among the people given the opportunity this
November to become rich and popular by joining the Great ILLUMINATI.
This is an open invitation for you to become part of the world's
biggest conglomerate and reach the peak of your career. a worthy goal
and motivation to reach those upper layers of the pyramid to become
one among the most Successful, Richest, Famous, Celebrated, Powerful
and most decorated Personalities in the World???
If you are interested, please respond to this message now with =E2=80=9CI
ACCEPT" and fill the below details to get the step to join the
Illuminati.
KINDLY FILL BELOW DETAILS AND RETURN NOW.....
Full names: ....................
Your Country: .................
State/ City: .............
Age: ....................
Marital status: ....................
Occupation: ....................
Monthly income: ....................
WhatsApp Number: ......
Postal Code: .....
Home / House Address: .....
NOTE: That you are not forced to join us, it is on your decision to
become part of the world's biggest conglomerate and reach the peak of
your career.
Distance is not a barrier.
