Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFA589429
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiHCVwn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCVwm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 17:52:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FDF5A3DA
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 14:52:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so18220849lfs.0
        for <linux-ext4@vger.kernel.org>; Wed, 03 Aug 2022 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=jZzlbYad3RAe1QGeDgm//GXYN4JcEyAlGqRtF/xVcXU=;
        b=Tczj+UmcfihgKEqZA3SSCkmUpzmsNJIiAv+0DtiRfi6y1zLMp6Iner7ZeS2BshA/pm
         jnTmWk2k2IQTm1YAe/4pkJY3v2Wyz7z4QcmxYl2CoDNEMDV59KmTMv2EeA0o19rXbhA1
         tz2bVN8ZkIiYHAYd2CvYYBDvQE4lzhGN2G3pjqVL0t/9zLNLXpjkd6MNpPeXePOzhsO3
         v6Sl7K4lAae7s+ive54Id+RlC8VQAzBoz88zOonxMjMYLFmWmub4wwBNyzViydyvnh4f
         itrdLmof2PlXCsIxQLP8hosVk0OR+CPKDrG1vQALxBoHSP36lUJpdRM3mecbIGNjaZko
         kjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=jZzlbYad3RAe1QGeDgm//GXYN4JcEyAlGqRtF/xVcXU=;
        b=0UMIL3UM3GhYeh32vdQ0bEUIDhSEK5O1kpUrUGy57lOVy/tjkq/zw8e2MtkFxTF9fJ
         QqCaN87XgHsOjTrDP758lLE0ns7NvGFlIEoGEDBt/dW20C/U6i4Hav9VfM5rTm8h9/uS
         QuXXZ0vsM5Pv5cwi4VvXY7vxqfzCD8NjbzIVEynytOWzF7ryWI6gZ8lkM68dGELnyq/X
         oEKE3aheUYFYrLxE5s2sf3Xw5OXbB50YD4LLGK8vlaFqNdCOJ/kMaUqffmED2bZqNFGp
         yc2Vgr274XE+FHLESVBTE8t83rcsE+gSBRrYK7etauJCsR3B1NlfFMji+SJN6DrNiZo2
         xi+Q==
X-Gm-Message-State: ACgBeo0iALx3fOkdJZLsZnxlqkPSjOJoZbzEpoxnhm5z14sTSNU0zft1
        7d3Glz/fo43gliIEckAx++A=
X-Google-Smtp-Source: AA6agR556ETkqxGgeGXiDM4eYC/YiWRmVxqIIOOF9Ovd7LIQxP+aro8v2wgtIUQorLOT6T3cFVEFkw==
X-Received: by 2002:ac2:4e11:0:b0:48b:16d8:fbe6 with SMTP id e17-20020ac24e11000000b0048b16d8fbe6mr2817333lfr.640.1659563558829;
        Wed, 03 Aug 2022 14:52:38 -0700 (PDT)
Received: from smtpclient.apple ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e3211000000b0025e4e7c016dsm1241339ljy.16.2022.08.03.14.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 14:52:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] e2fsprogs: avoid code duplication
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <YurTVlGWqwym2Hgg@mit.edu>
Date:   Thu, 4 Aug 2022 00:52:34 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A850E8AB-1B4D-4956-9933-CF32DF0762BC@gmail.com>
References: <20220803075407.538398-1-alexey.lyashkov@gmail.com>
 <YurTVlGWqwym2Hgg@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for pointing to the libsupport. I looking into kernel-jbd.h as =
example (it also don=E2=80=99t export outside of e2fsprogs),
but  libsupport is lost from my radar.

Lack of tag v3 is big lost also. It mean debugfs don=E2=80=99t able to =
print log records correctly if block number over 2^32.

Alex

> On 3 Aug 2022, at 22:58, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Wed, Aug 03, 2022 at 10:54:07AM +0300, Alexey Lyashkov wrote:
>> debugfs and e2fsck have a so much code duplication in journal =
handing.
>> debugfs have lack a many journal features handing also.
>> Let's start code merging to avoid code duplication and lack features.
>=20
> This is definitely worth doing, and as you've pointed out, there are a
> number of features which are in e2fsck/journal.c, which are not in
> debugfs/journal.c.  The most notable one which I picked up on is the
> fast_commit code --- which is in the master/next branch, but not in
> the maint branch.
>=20
> I suggest that we move the functionality into the libsupport library
> first.  I want to make sure we get the abstractions right before we
> "cast them into stone" by moving the functions to libext2fs.
> Libsupport is not exported outside of e2fsprogs, so if we decide we
> want to change function signatures, or make some functions private, we
> can do that more easily if we experiment with moving things into
> libsupport first.
>=20
> 						- Ted

