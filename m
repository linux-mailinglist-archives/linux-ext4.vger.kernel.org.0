Return-Path: <linux-ext4+bounces-1452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D805D86DD19
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940552817C2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E669D26;
	Fri,  1 Mar 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNDSPknY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2A69D37;
	Fri,  1 Mar 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281804; cv=none; b=RY1G6o+Upl8MpDOSrUU/ydtzk3uAb4cm+JffQK1VRImbxM5ev2gBB/q6Urm6s1YlMegX3ND+uceM1rPRTaAxkxSUoSiU3z6qxXWxQjFsgXnriCKKSDWMqVeZKZl0kPcxsnmmmbS7UaG6aXw3DOAK0NzAsJptC0mU8jHUcT8Q5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281804; c=relaxed/simple;
	bh=fIlpR6h9TKlVBoQgObZveQagfzEbrFMz1qvxqhTbQbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D39okgR8gH8wSnbetEOCPWgSOnQciDEZE6PTriw/TmH+9C4rBk/RL1AKxbJOm2h+FUC4Dr2PACLGKtrXTkPYv1YjXCx3svTendD8oMTTFekPytqJ4645tF6ThDjWHpeC1gbg0P3nDPTcdJ+dEtaobnScS+5GRuDYSizljBQL51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNDSPknY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF1C433F1;
	Fri,  1 Mar 2024 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709281804;
	bh=fIlpR6h9TKlVBoQgObZveQagfzEbrFMz1qvxqhTbQbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNDSPknYvpVPD78pZkm3Hj3Rz2pt57ZBWl5owjmre4MrOMaH2+gNiE2gANIOjPmVf
	 FA4mIfjyUwLEDgY2vmAgkFs/43Jo+SLi+M0ZWQ/0mwfTEqlVvtxSgz/ft070r657ac
	 RehUP94ZSV99ONsF6hruvIaZlyld2lyDVUXRT3qUOrZyPzMkAqFuFZ6IYI2iWf6pYj
	 hW/UQBlf8eTm5IhKj/pIeSpOitOWLHuadquVsGz8p107BdzZuqrMpu6mzXo/VDwjnl
	 Fm0J58tdUM6to+BUED+OHqgI4yxK+T4FRT26ARFcpRg3O/Y+b6K2UMp2zZS89xK56c
	 1VBFTY0dIePQA==
Date: Fri, 1 Mar 2024 09:29:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org, daniel.diaz@linaro.org, 
	linux@roeck-us.net
Subject: Re: [PATCH 1/2] ext4: alloc test super block from sget
Message-ID: <20240301-kommst-urzustand-e7eb09ccb5b8@brauner>
References: <20240301120816.22581-1-shikemeng@huaweicloud.com>
 <20240301120816.22581-2-shikemeng@huaweicloud.com>
 <20240301-neuland-zoomen-4152b34c6fba@brauner>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301-neuland-zoomen-4152b34c6fba@brauner>

On Fri, Mar 01, 2024 at 09:25:59AM +0100, Christian Brauner wrote:
> On Fri, Mar 01, 2024 at 08:08:15PM +0800, Kemeng Shi wrote:
> > This fix the oops in ext4 unit test which is cuased by NULL sb.s_user_ns
> > as following:
> > <4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
> > <4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
> > <4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174)
> > <4>[ 14.346696] alloc_inode (fs/inode.c:268)
> > <4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
> > <4>[ 14.348016] new_inode (fs/inode.c:1033)
> > <4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:3719)
> > <4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
> > fs/ext4/mballoc-test.c:314)
> > <4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c:443)
> > <4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30)
> > <4>[ 14.351530] kthread (kernel/kthread.c:388)
> > <4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
> > <0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)
> > 
> > Alloc test super block from sget to properly initialize test super block
> > to fix the issue.
> > 
> > Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  fs/ext4/mballoc-test.c | 46 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 31 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> > index 12d0b22cabe1..1da52bbf4599 100644
> > --- a/fs/ext4/mballoc-test.c
> > +++ b/fs/ext4/mballoc-test.c
> > @@ -21,16 +21,27 @@ struct mbt_ctx {
> >  };
> >  
> >  struct mbt_ext4_super_block {
> > -	struct super_block sb;
> > +	struct ext4_super_block es;
> > +	struct ext4_sb_info sbi;
> >  	struct mbt_ctx mbt_ctx;
> >  };
> >  
> > -#define MBT_CTX(_sb) (&(container_of((_sb), struct mbt_ext4_super_block, sb)->mbt_ctx))
> > +#define MBT_SB(_sb) (container_of((_sb)->s_fs_info, struct mbt_ext4_super_block, sbi))
> > +#define MBT_CTX(_sb) (&MBT_SB(_sb)->mbt_ctx)
> >  #define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
> >  
> >  static const struct super_operations mbt_sops = {
> >  };
> >  
> > +static void mbt_kill_sb(struct super_block *sb)
> > +{
> > +}
> > +
> > +static struct file_system_type mbt_fs_type = {
> > +	.name			= "mballoc test",
> > +	.kill_sb		= mbt_kill_sb,
> > +};
> > +
> >  static int mbt_mb_init(struct super_block *sb)
> >  {
> >  	int ret;
> > @@ -72,43 +83,48 @@ static void mbt_mb_release(struct super_block *sb)
> >  	kfree(sb->s_bdev);
> >  }
> >  
> > +static int mbt_set(struct super_block *sb, void *data)
> > +{
> > +	return 0;
> > +}
> > +
> >  static struct super_block *mbt_ext4_alloc_super_block(void)
> >  {
> > -	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
> > -	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> >  	struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
> > +	struct super_block *sb = sget(&mbt_fs_type, NULL, mbt_set, 0, NULL);
> > +	struct ext4_sb_info *sbi;
> >  
> > -	if (fsb == NULL || sbi == NULL || es == NULL)
> > +	if (fsb == NULL || sb == NULL)
> 
> sget() returns error pointer on failure. So you should check for IS_ERR(sb).

You also want to unlock that superblock up_write(sb->s_umount) if it
succeeded and then call deactivate_super() when you are done with it in
mbt_kunit_exit().

