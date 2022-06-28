Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27355E9EA
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiF1Qfa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiF1Qem (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 12:34:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0430F61
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 09:31:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x3so23295961lfd.2
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plu-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7yiGZ94Gh4vRl9mZUVCwfYEf1dp4ree/KLDLMgwW5e8=;
        b=MUZ0GBpkxp77AfAFWH7bm1QaMhyK2iGxLJa56o53qx9iulhA/45B7KbcfqafXC6Btf
         KJGWtUBjqfRNFDwIKuq+gia90d9kJ0Q/qOtp0U//8Kdy9fQJIWPtG3rVHhKZA7Wnc5LU
         bOTxKBrLX6ey6ZNTkOuGlyKECjQVnZLLjyuvaQ8BfX7+8r32uAsJPgHI8E7D5oDkeJlQ
         vNvr2lz/2Kryfe5bkiGPM9slK9A9RvADM7SFPiDJNjzsnKbFeEJGbkZx8BK/acg+dH6D
         jXRWm2xnsAcC+iWfgKYGRdQIAKPIsLspmeZRRAMs4HBJcNQ685oBqo1sA8iKXwD0I4ZW
         LwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7yiGZ94Gh4vRl9mZUVCwfYEf1dp4ree/KLDLMgwW5e8=;
        b=vVddnz+ecD9rLFDb70/F0tzddl5DUCCabwDzvLJqyPHeNV1xxag9i2QWxo4WBqFYLz
         Ms8adz0GR0FMJvbzJJVuslrXU+xuDnR0Pcu7DpQcQe0erkY3EoJgXy8a6r3IXPYjtVLJ
         bD3MHdBRc+f2hV+BHh1G5ecFVi6QwVYp2MMOTHfESzYl6MJdz3BDfnK3Ypsvq/JNZFn3
         bu4taSaZE9Ew2vtXSYZYBIkL90v6iV0MRltp6lnDv0Wx6pUJ+r61NusOu86Q5CNnBOLB
         Yu1nXCJaNy3oj9+SYcYxHO++wi2YCsIuQq+otSpkkRe9FrqNmSmd2MQKpRW65qtWu9dF
         IiWg==
X-Gm-Message-State: AJIora/iaeAjrLZpKtecmJZzjPOHE+snX3PHdTjG9jymfEvZ832AwkbS
        Qa1uAAEPK0j4H+pnURvoE3SW08oOKZ/xIqHtqNUh1Q==
X-Google-Smtp-Source: AGRyM1uqI0ksrbq2MGC5gZHbgpMsZ5sCP+fLEe13fKjfORGch2KGCDLfwvpWSK1NnrGjf0vpfh6kBSVJlnI/fvC7gdk=
X-Received: by 2002:a05:6512:1089:b0:47f:6373:6241 with SMTP id
 j9-20020a056512108900b0047f63736241mr12545519lfg.164.1656433898846; Tue, 28
 Jun 2022 09:31:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:da8c:0:b0:1f5:486:75c3 with HTTP; Tue, 28 Jun 2022
 09:31:37 -0700 (PDT)
Reply-To: crypto.investorstrading@gmail.com
From:   SIEGL RONNY <lindnelg@plu.edu>
Date:   Tue, 28 Jun 2022 17:31:37 +0100
Message-ID: <CAJeMfn+_CYuNk3AY2-TTbzG=OMt+i5Ck+3-GuqB6oy3dB56ppQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Hallo,

Verdienen Sie w=C3=B6chentlich 65.000 bis 130.000 US-Dollar im
Bitcoin-Investitionshandel. Es ist sehr lukrativ, dass Sie
m=C3=B6glicherweise keine Arbeit verrichten m=C3=BCssen, nur falls Sie eine=
n
9-5-Job haben, wird dies Ihre Arbeit nicht beeintr=C3=A4chtigen. FRAG MICH
WIE? Kontaktieren Sie uns f=C3=BCr ein direktes Gespr=C3=A4ch =C3=BCber Wha=
tsApp: +1
(201) 590=E2=80=914385
