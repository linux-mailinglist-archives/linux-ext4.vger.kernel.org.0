Return-Path: <linux-ext4+bounces-3736-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B44953D47
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8644C1C228A8
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB91552EE;
	Thu, 15 Aug 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CnowL2va"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978ED14F12F;
	Thu, 15 Aug 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760223; cv=none; b=NUlZPlTZFjogWqLXCp2xM83hg7itRPWtvFWO3Nh4oCRlzbe7bmZfe/PgBZdZ+9nK46ZHcpjWKJ4yNCe6W/zWkVxr1VuzdrWDMBXiyn5jKR784bnsX+jldIiqgTpcbvkF8QlhRgJTB4VfJzK7by1A069cXvhAT8Ff5Fi5fwD/R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760223; c=relaxed/simple;
	bh=/FiOEv3+fuK+fRr7TYiTlNmvfk6cliwV5N+0K7DoudA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUAe6lmmkXQy//rfOZ1pt7eJG/XI3+khQgdFZcDBZZXOfs7bmD0xVlFecmWhyo0zWZaYwZwY3bA/4UkdQyP7PQ1Dilye5+O3EeZue2VoGRHuxdtMaUW4gp0+O5mXjOLUWEbXRbaquZmJAfl9aaf+oeoWVKxciJarl7cFafuMdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CnowL2va; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FAfkGe025484;
	Thu, 15 Aug 2024 22:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=ejPq03iTPyAQAfZo6/4iaQns1QV
	WO8J2L0RjkZ5jv2o=; b=CnowL2vaVKNlBK28LQbSny10nqmmx2XbIM1du8N1zko
	mk2kT3tfKeehXz1WuImbx+fhBn8POUVjT6hmSvKKg/An+WCdwQ293MNNQnRxyy0M
	Fw2nt4BMB/9LDz1AEjr3K8UMWcdtnU1wmYoxrU6pCFcKsfLCZDgvEJ9of+MrOwuA
	4YeVN1+602Vmf5ClqrM+EQrluCN94cdqqRvbOnG88dSonvgA8KWK9c1rABOU2eAS
	PXBJ7vTr9ZwQKEHJXxS4xq6ViMc1fwQ9A0j0oQQTSEMCwMcQkM0NtAsd83S3g8eu
	yMs3ieLP0rYFLu1OQkPSjL8GzaHZGkbzyeDG9R1zm3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6nn74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 22:16:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47FMGpMk017102;
	Thu, 15 Aug 2024 22:16:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6nn72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 22:16:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47FIPxfb029759;
	Thu, 15 Aug 2024 22:16:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmrm1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 22:16:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FMGl8W51053038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 22:16:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA6B420067;
	Thu, 15 Aug 2024 22:16:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C1F620063;
	Thu, 15 Aug 2024 22:16:45 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.37.23])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Aug 2024 22:16:45 +0000 (GMT)
Date: Fri, 16 Aug 2024 03:46:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [PATCH] ext4: fix divide error in ext4_mb_regular_allocator
Message-ID: <Zr5+SvVwqIWeO75m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <000000000000b1b164061f96213d@google.com>
 <tencent_42D9D2CB066909BF6EDDAEDB8C8067F3C606@qq.com>
 <Zrw4/N7a/XrjOgtS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrw4/N7a/XrjOgtS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3trqDdTCGyBhYNmJLThD8R3jqKpFqDrm
X-Proofpoint-ORIG-GUID: iaWJddupJrNeP1AWGMvtz9RMf4IbaY8q
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_14,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150161

On Wed, Aug 14, 2024 at 10:26:47AM +0530, Ojaswin Mujoo wrote:
> On Wed, Aug 14, 2024 at 10:12:00AM +0800, Edward Adam Davis wrote:
> > Before determining that the goal length is a multiple of the stripe size,
> > check CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN first.
> > 
> > Fixes: 1f6bc02f1848 ("ext4: fallback to complex scan if aligned scan doesn't work")
> > Reported-and-tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/ext4/mballoc.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 9dda9cd68ab2..451f92cde461 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2928,13 +2928,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >       if (cr == CR_POWER2_ALIGNED)
> >         ext4_mb_simple_scan_group(ac, &e4b);
> >       else {
> > -       bool is_stripe_aligned = sbi->s_stripe &&
> > +       bool is_stripe_aligned = (cr == CR_GOAL_LEN_FAST ||
> > +         cr == CR_BEST_AVAIL_LEN) && sbi->s_stripe &&
> >           !(ac->ac_g_ex.fe_len %
> >             EXT4_B2C(sbi, sbi->s_stripe));
> 
> Hi Edward, 
> 
> Thanks for the patch. So I didn't get a chance to look at syszcaller
> report but assuming that EXT4_B2C(sbi, sbi->s_stripe) is becoming 0,
> I'm not understanding how is this patch fixing the bug?
> 
> It just seems to short circuit the actual bug but we might still hit it
> right? 
> 
> As for EXT4_B2C(stripe) becoming zero, I have 2 observations:
> 
> 1. We should definitely be using EXT4_NUM_B2C() here to make sure we
>    don't get 0 if stripe is less than cluster size.
> 
> 2. That being saidIm not sure if it's even possible for this to become zero
>    because we do check that stripe size is a multiple of cluster size in
>    ext4_fill_super, else we disable it:

So I figured out the issue. It is indeed possible for this to happen
since we forgot to add the below check on remount path in the following 
patch:

	c3defd99d58c ("ext4: treat stripe in block unit")

The patch at the end of the mail should fix this issue. Once syscaller
tests it I'll send out the patch addressing this as well as making the
change mentioned in point 1 of previous email.

> 
>   /*
>    * It's hard to get stripe aligned blocks if stripe is not aligned with
>    * cluster, just disable stripe and alert user to simpfy code and avoid
>    * stripe aligned allocation which will rarely successes.
>    */
>   if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
>       sbi->s_stripe % sbi->s_cluster_ratio != 0) {
>     ext4_msg(sb, KERN_WARNING,
>        "stripe (%lu) is not aligned with cluster size (%u), "
>        "stripe is disabled",
>        sbi->s_stripe, sbi->s_cluster_ratio);
>     sbi->s_stripe = 0;
>   }

We disable stripe size in __ext4_fill_super if it is not a multiple of
the cluster ratio however this check is missed when trying to remount.
This can leave us with cases where stripe < cluster_ratio after
remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
unforeseen bugs like divide by 0.

Fix that by adding the check in remount path as well.

Additionally, change the users of EXT4_B2C(sbi->s_stripe) to
EXT4_NUM_B2C() so that if we ever accidentally hit this again, we can
avoid the value becoming 0. This should not change existing functionality.

#syz test: https://github.com/torvalds/linux master

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/super.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..8ca6bbc337a6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5165,6 +5165,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
 	return 0;
 }
 
+/*
+ * It's hard to get stripe aligned blocks if stripe is not aligned with
+ * cluster, just disable stripe and alert user to simpfy code and avoid
+ * stripe aligned allocation which will rarely successes.
+ */
+static bool ext4_is_stripe_incompatible(struct super_block *sb, unsigned long stripe)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	return (stripe > 0 && sbi->s_cluster_ratio > 1 &&
+		stripe % sbi->s_cluster_ratio != 0);
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
@@ -5272,13 +5284,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount3;
 
 	sbi->s_stripe = ext4_get_stripe_size(sbi);
-	/*
-	 * It's hard to get stripe aligned blocks if stripe is not aligned with
-	 * cluster, just disable stripe and alert user to simpfy code and avoid
-	 * stripe aligned allocation which will rarely successes.
-	 */
-	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
-	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
+	if (ext4_is_stripe_incompatible(sb, sbi->s_stripe)) {
 		ext4_msg(sb, KERN_WARNING,
 			 "stripe (%lu) is not aligned with cluster size (%u), "
 			 "stripe is disabled",
@@ -6441,6 +6447,15 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 
 	}
 
+	if (ctx->spec & EXT4_SPEC_s_stripe &&
+	    ext4_is_stripe_incompatible(sb, ctx->s_stripe)) {
+		ext4_msg(sb, KERN_WARNING,
+			 "stripe (%lu) is not aligned with cluster size (%u), "
+			 "stripe is disabled",
+			 ctx->s_stripe, sbi->s_cluster_ratio);
+		ctx->s_stripe = 0;
+	}
+
 	/*
 	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
 	 * two calls to ext4_should_dioread_nolock() to return inconsistent
-- 
2.39.3

