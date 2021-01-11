Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A352F0AB7
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jan 2021 02:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAKBTK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Jan 2021 20:19:10 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:37960 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAKBTK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Jan 2021 20:19:10 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210111011826epoutp02561c3828f54fd7077f609644de788fce~ZCLLdYeDJ0979609796epoutp02m
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jan 2021 01:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210111011826epoutp02561c3828f54fd7077f609644de788fce~ZCLLdYeDJ0979609796epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610327906;
        bh=9K/mOXjs5JwezfaILQ5i7Rqtdyes2OsAScj48k0fffU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=r2hECrldFJcQER8NiG7n9aBu3iuZEz7rEHBJHtbuOhPm3a5Nc+VgG8YbN+7wvs5X+
         NFw8enIyk9uQfh+/K/sjiBUj0bIrpjVlLZas8vi9hbR5Tuw1uWqMFBppQb/tPabOF0
         Ui10FcTwTmlTzSqV0/s+gx/ubAqpcRuBXIoaYHZk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210111011825epcas2p3db6e57bd517399b3c3a5da504dd5f58b~ZCLLBuxcs1759717597epcas2p31;
        Mon, 11 Jan 2021 01:18:25 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DDbSH0xgPz4x9Q6; Mon, 11 Jan
        2021 01:18:23 +0000 (GMT)
X-AuditID: b6c32a45-34dff7000001297d-98-5ffba75d093a
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.57.10621.D57ABFF5; Mon, 11 Jan 2021 10:18:21 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] ext4: Change list_for_each to list_for_each_entry
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAD+ocbwuZ-y--YoC=1khtaQ1A2oYqyQtKGsvVHNvngzsuN0ByA@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210111011821epcms2p626def5bccbea257ffbcd95257c1539cc@epcms2p6>
Date:   Mon, 11 Jan 2021 10:18:21 +0900
X-CMS-MailID: 20210111011821epcms2p626def5bccbea257ffbcd95257c1539cc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmuW7s8t/xBm39fBZfv3SwWKx6EG6x
        srGFyWLmvDtsFpd3zWGzaO35ye7A5tGyudxj56y77B5NZ44ye/RtWcXo8XmTXABrVAOjTWJR
        ckZmWapCal5yfkpmXrqtUmiIm66FkkJGfnGJrVK0oYWRnqGlqZ6JpZ6ReayVoYGBkamSQl5i
        bqqtUoUuVLeSQlFyAVB1SWpxSVFqcipQqMihuCQxPVWvODG3uDQvXS85P1dJoSwxpxSoT0nf
        ziYjNTEltUgh4QljxpXzM9gK9vBXnF9/m6mB8QR3FyMnh4SAiUTXt0lsILaQwA5GiXebGbsY
        OTh4BQQl/u4QBgkLC3hJbNj1jhmiREli/cVZ7BBxPYlbD9cwgthsAjoS00/cB4uLCMRJrD56
        GmgkFwezwC1GiU3nnrND7OKVmNH+lAXClpbYvnwrWDOnQKDEzveP2CDiGhI/lvUyQ9iiEjdX
        v2WHsd8fm88IYYtItN47C1UjKPHg526ouKTEsd0fmCDseomtd34xghwhIdDDKHF45y1WiIS+
        xLWOjWBH8Ar4Sqw99h1sMYuAqsSOL/uhml0k/t7YDhZnFpCX2P52DjMoUJgFNCXW79IHMSUE
        lCWO3GKBqOCT6Dj8F+7FHfOeQE1Rk1j3cz0TRLmMxK15UFd6SDxp7WSfwKg4CxHQs5CsmoWw
        agEj8ypGsdSC4tz01GKjAkPkaN7ECE6fWq47GCe//aB3iJGJg/EQowQHs5II78JdP+KFeFMS
        K6tSi/Lji0pzUosPMVYBPTmRWUo0OR+YwPNK4g3NDIzMTI1NjI1NTUzJFjY1MjMzsDS1MDUz
        slAS5y02eBAvJJCeWJKanZpakFoEs5yJg1Oqgcl68sWDn79Otre9rC7Rasay+vTLiksMuVP6
        N2buOrav73P+MqHEWtcstScOrS9CBSQrTUxXLtjOVuDr5plycwJL0tMK1+9MBu9Lt+z+8HhS
        YK6l8aXpLPtkA6tVpeIEi0us9mj01vzef+t9+9P2pjn+HjruhlyzP8tzLvr9hmf147A3k1cK
        23kc2xRbvCJvl4nA/6/im2aFtB2XbbU4dujaSp7Xys+XbdayNdx3zuvC41n5Bc57+3ldH0Tv
        W5XctyiaYY1jM5dx4KtTcVNn8lxKY/6R2v153866eUWnRG7/6uT6y//W6NFs1xU3N3i6xB/k
        5fX1c7UOi1/c2MaeU3+qfP7RGxKFaxZ6GlUIhymxFGckGmoxFxUnAgB3IYRqbQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51
References: <CAD+ocbwuZ-y--YoC=1khtaQ1A2oYqyQtKGsvVHNvngzsuN0ByA@mail.gmail.com>
        <20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
        <CAD+ocbwjVsiPNnp3RShN7eRDm5ZRDMwgk5uPO1at-KeX-osyqg@mail.gmail.com>
        <CGME20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p6>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Harshad,

> > > list_for_each + list_entry can be changed to list_for_each_entry
> > > It reduces number of variables and lines.
> > >
> > > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > > ---
> > >  fs/ext4/fast_commit.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 5b6bb3ef0f33..dc58471971db 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -915,13 +915,11 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
> > >         struct super_block *sb = (struct super_block *)(journal->j_private);
> > >         struct ext4_sb_info *sbi = EXT4_SB(sb);
> > >         struct ext4_inode_info *ei;
> > > -       struct list_head *pos;
> > >         int ret = 0;
> > >
> > >         spin_lock(&sbi->s_fc_lock);
> > >         ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
> > > -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> > > -               ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> > > +       list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> > >                 ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
> > >                 while (atomic_read(&ei->i_fc_updates)) {
> > >                         DEFINE_WAIT(wait);
> > > @@ -1099,8 +1097,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
> > >                 goto out;
> > >         }
> > >
> > > -       list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> > > -               iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
> Variable "pos" isn't used anymore after this patch. You removed it for
> the ext4_fc_submit_inode_data_all() function, but missed removing it
> in this function. That's throwing me a warning.
> 
Thanks for comment, I will remove this. And I will change some list_for_each_safe
macro at new patch.

Thanks,
Daejun
