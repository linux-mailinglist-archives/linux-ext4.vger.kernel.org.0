Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94044D236
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 08:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKHNL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Nov 2021 02:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKHNL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Nov 2021 02:13:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA1C061766
        for <linux-ext4@vger.kernel.org>; Wed, 10 Nov 2021 23:10:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z34so11952640lfu.8
        for <linux-ext4@vger.kernel.org>; Wed, 10 Nov 2021 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RyMTikuXuk4CwLPZjgMGVBZcNZ51SDxS//CXZPYeZ/4=;
        b=TN4c7h2e/UCWifrni1jo+Y6A+vVLO5/t34cy3+aQmxeaRqfzrAD6IgEl965FgWhRrn
         ZaXX8J4PF/OB8Sl2WREsFKpXQn3MnjVupfntFo/boJizdWQx56UlNxnfceGhlN00SARC
         +4bNNrseVdc9jirsmKKkWmvMhlHJURDrZ0vKprBoEwWUwaLv+yVtfsJcOtPKNcHzU9KS
         RCgi33CFEncFpwnItjWzks9wzSgxwDr+lJqJyG8E2QT4FwDWyrFGuK2gRddDgPF3IPAV
         5TULXcQEVpkTBCuKgJOlUXgFCzS9Erxdql59XgQRvJS0vL+YHvYcqa8+ewg8PKfup7Tv
         fv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RyMTikuXuk4CwLPZjgMGVBZcNZ51SDxS//CXZPYeZ/4=;
        b=6bxraSzMegZjRTRnUiv8VFs2h7zcZFDreO94/CSxs7+SZRxGZq3TXB/CcPVoj6XYU9
         +z/RqvYWCyA9eMrB4WEuTci7b5iBDIrIqFn+AZUvSR49LD1DGqW7C2RBgJcFCNEAKKpF
         lcXgn2ZlfxWHEMo97pEuYp9EKvof7Rbzv1jrCZUOh3bPtxAVZbxw7fPAbFavQ7y0uyfO
         VeqHeV4s1J5FHH6VGNkifVMz4B8r6HJkHkOu0QSbH9WKb6X+WFRS/YBuA+eXreWiI849
         lgHFZpaHjRbaz7rv2ZvKASpVDbeOKEnPXVJ8X2Z3Ob95JvbKMq/WrnpPajSww0ar4zD/
         RRag==
X-Gm-Message-State: AOAM530C2y0MdNfGMZxtB854gBQRYxOVO5e6Kf7y9qXZCuM3jQE0SAS3
        JYWrQAutDix8ox1AS74zqJFeJn1ld1iCRVoE2bwh0nMF0okoyw==
X-Google-Smtp-Source: ABdhPJyM8qNk1VFbeydTuDobQQl+EdB14gfmFVkTBbwYQQyEP8QiF84kDFhRBiTCdaL4kvm1GSdv/KXTmYiCIYT7P1Y=
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr4781494lfg.278.1636614620849;
 Wed, 10 Nov 2021 23:10:20 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5bC55qyj?= <yinxin.x@bytedance.com>
Date:   Thu, 11 Nov 2021 15:10:10 +0800
Message-ID: <CAK896s5szH8qbDGBDo74hyz5iM4QrjbMJkMjh-f1sZh6K0ozTg@mail.gmail.com>
Subject: [Question] ext4: different behavior of fsync when use fast commit
To:     harshadshirwadkar@gmail.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,


Recently, I=E2=80=98m doing some testing with fast commit feature , and fou=
nd
there is a slight difference on fsync compared with the normal
journaling scheme.

Here is the example:

-mkdir test/

-create&write test/a.txt

-fsync test/a.txt

-crash (before a full commit)



If fast commit is used then =E2=80=9Ca.txt=E2=80=9D will lost. While the no=
rmal
journaling can recover it.

Refer to the description of fsync [1],  fsync will not guarantee the
parent directory to be persisted. So I think it is not an issue.

But fast commit did change the behavior of fsync in ext4,  is this as expec=
ted ?



For the root cause of this difference, I found that fast commit will
not add a EXT4_FC_TAG_CREAT tag for directory creation.

In func ext4_fc_commit_dentry_updates(), only directories in s_fc_q
list can be added with EXT4_FC_TAG_CREAT,but seams the newly created
directory inode has no change to be added to s_fc_q.



Shall we just change the =E2=80=9Cenqueue=E2=80=9D param of ext4_fc_track_t=
emplate()
to 1 , which in __ext4_fc_track_create()?  And make fast commit record
all the inode creation, and do the same things as normal journaling.



[1] https://man7.org/linux/man-pages/man2/fdatasync.2.html



BR,

Xin Yin
