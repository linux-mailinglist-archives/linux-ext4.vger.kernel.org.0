Return-Path: <linux-ext4+bounces-3513-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E076940D87
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 11:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D0EB25946
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F35195FE6;
	Tue, 30 Jul 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dtYWyHKd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0A195F17;
	Tue, 30 Jul 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331679; cv=none; b=PEN5mSkkVqoz9iJZDDSjKypTjyV2foZsyLBmuTnW+/YLXdJII5OZ0PGlOp5EhRNQzhplOyaw80seDNkn0/OxU9czokOMSSykaWdyu9mo7VytFuj1YX/AVdO3sWqGax3ygbZsEzROITnSGv769SyF2M9l4gUgQp2YT+9fzGNRRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331679; c=relaxed/simple;
	bh=B/fHpJWiyhdZcmh48lcydgKpP8GAq839OdLOR+6Cr6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWGTzQdOYpVfXM5X9nwv+CvfKyUqSZP0I+bp/+D2j1a4dNqWphogop4Zd8mIzW9QCX88Ey9LBnKx77NWAEpY05rlFdUnzBzCK//ejdSGjCIEWs8YHZlH6uwHtj3lxXg1eFz5b6LkSJ4iS7uD5EO1KuaepIL3Ku6vJiFD98WjUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dtYWyHKd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8xbj2021798;
	Tue, 30 Jul 2024 09:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=1zfvUjVbawcbelzzSX0EtfDqqr6
	j22Zk5GgnOPEo5/Q=; b=dtYWyHKdrWx6d2U6+PZA0K6D6z8vzVth1k3QytAE9Pc
	UdSc/I3QIOV+65SYZyCuElYCZFa8KPSc6Gf8FObwgW+WIsrobXPLXg2OZfCYU+u5
	Nyt4SZQsvHeTAaILIOGYZX1AaGGpalrEpJBLuLq/YS1QoyNJdBQH73Ehb7DsMvuG
	75U9iSn5VmmKoFROJibTq7lO58L3T+FIbF+H7q4YKLb9O/HCAsgLep6GpvUA7Bhp
	Oczo5mGo9oltwsp2TIzgGaR/xYwUZKgwmFjpWVDXdUkgV4KOM6qhFNUf/YoG0A9Z
	Kxi6MBG8UYHYEHdJedVflk2KGmZ6+3gb3hJYrcOtbrA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pw5481rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:26:41 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U9Qeop005732;
	Tue, 30 Jul 2024 09:26:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pw5481r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:26:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U8AKZv003857;
	Tue, 30 Jul 2024 09:26:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndembn6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 09:26:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U9QZKg54657330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 09:26:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA43F20043;
	Tue, 30 Jul 2024 09:26:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2CEB20040;
	Tue, 30 Jul 2024 09:26:33 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 30 Jul 2024 09:26:33 +0000 (GMT)
Date: Tue, 30 Jul 2024 14:56:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Baokun Li <libaokun1@huawei.com>, stable@kernel.org
Subject: Re: [PATCH 05/20] ext4: fix slab-use-after-free in
 ext4_split_extent_at()
Message-ID: <Zqixx5kP40VJlxa3@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-6-libaokun@huaweicloud.com>
 <ZqTNtWchBMRIVmqL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <deec537f-b9f9-46b4-960a-44e70e272d79@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deec537f-b9f9-46b4-960a-44e70e272d79@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pHes97QtoXlkU2eIZW36bPs-8K4tHvCc
X-Proofpoint-ORIG-GUID: 2j1YxPfDfZeO31-br_uuT2l4clFLQdM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=825 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300065

On Tue, Jul 30, 2024 at 04:57:35PM +0800, Baokun Li wrote:
> On 2024/7/27 18:36, Ojaswin Mujoo wrote:
> > On Wed, Jul 10, 2024 at 12:06:39PM +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > We hit the following use-after-free:
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
> > > Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
> > > CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
> > > Call Trace:
> > >   <TASK>
> > >   kasan_report+0x93/0xc0
> > >   ext4_split_extent_at+0xba8/0xcc0
> > >   ext4_split_extent.isra.0+0x18f/0x500
> > >   ext4_split_convert_extents+0x275/0x750
> > >   ext4_ext_handle_unwritten_extents+0x73e/0x1580
> > >   ext4_ext_map_blocks+0xe20/0x2dc0
> > >   ext4_map_blocks+0x724/0x1700
> > >   ext4_do_writepages+0x12d6/0x2a70
> > > [...]
> > > 
> > > Allocated by task 40:
> > >   __kmalloc_noprof+0x1ac/0x480
> > >   ext4_find_extent+0xf3b/0x1e70
> > >   ext4_ext_map_blocks+0x188/0x2dc0
> > >   ext4_map_blocks+0x724/0x1700
> > >   ext4_do_writepages+0x12d6/0x2a70
> > > [...]
> > > 
> > > Freed by task 40:
> > >   kfree+0xf1/0x2b0
> > >   ext4_find_extent+0xa71/0x1e70
> > >   ext4_ext_insert_extent+0xa22/0x3260
> > >   ext4_split_extent_at+0x3ef/0xcc0
> > >   ext4_split_extent.isra.0+0x18f/0x500
> > >   ext4_split_convert_extents+0x275/0x750
> > >   ext4_ext_handle_unwritten_extents+0x73e/0x1580
> > >   ext4_ext_map_blocks+0xe20/0x2dc0
> > >   ext4_map_blocks+0x724/0x1700
> > >   ext4_do_writepages+0x12d6/0x2a70
> > > [...]
> > > ==================================================================
> > > 
> > > The flow of issue triggering is as follows:
> > > 
> > > ext4_split_extent_at
> > >    path = *ppath
> > >    ext4_ext_insert_extent(ppath)
> > >      ext4_ext_create_new_leaf(ppath)
> > >        ext4_find_extent(orig_path)
> > >          path = *orig_path
> > >          read_extent_tree_block
> > >            // return -ENOMEM or -EIO
> > >          ext4_free_ext_path(path)
> > >            kfree(path)
> > >          *orig_path = NULL
> > >    a. If err is -ENOMEM:
> > >    ext4_ext_dirty(path + path->p_depth)
> > >    // path use-after-free !!!
> > >    b. If err is -EIO and we have EXT_DEBUG defined:
> > >    ext4_ext_show_leaf(path)
> > >      eh = path[depth].p_hdr
> > >      // path also use-after-free !!!
> > > 
> > > So when trying to zeroout or fix the extent length, call ext4_find_extent()
> > > to update the path.
> > > 
> > > In addition we use *ppath directly as an ext4_ext_show_leaf() input to
> > > avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
> > > unnecessary path updates.
> > > 
> > > Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/ext4/extents.c | 21 ++++++++++++++++++++-
> > >   1 file changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 6e5b5baf3aa6..3a70a0739af8 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -3252,6 +3252,25 @@ static int ext4_split_extent_at(handle_t *handle,
> > >    if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> > >      goto out;
> > > + /*
> > > +  * Update path is required because previous ext4_ext_insert_extent()
> > > +  * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> > > +  * guarantees that ext4_find_extent() will not return -ENOMEM,
> > > +  * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> > > +  * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> > > +  * an incorrect ee_len causing the i_reserved_data_blocks exception.
> > > +  */
> > > + path = ext4_find_extent(inode, ee_block, ppath,
> > > +       flags | EXT4_EX_NOFAIL);
> > > + if (IS_ERR(path)) {
> > > +   EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
> > > +        split, PTR_ERR(path));
> > > +   return PTR_ERR(path);
> > > + }
> > > + depth = ext_depth(inode);
> > > + ex = path[depth].p_ext;
> > > + *ppath = path;
> > > +
> > Hi Baokun, nice catch!
> > 
> > I was just wondering if it makes more sense to only update path if we
> > encounter an error:
> > 
> >    err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> >    if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> >      goto out;
> >    else if (err < 0) {
> >      ...
> >      path = ext4_find_extent(inode, ee_block, ppath, flags | EXT4_EX_NOFAIL);
> >    }
> > 
> > I believe that's the only time we'd end up with the use after free issue
> > and this way we can avoid the (maybe tiny) performance overhead of calling
> > the extra find extent. What are your thoughts?
> > 
> > regards,
> > ojaswin
> Hi Ojaswin,
> 
> We're already there now, updating the path only on recoverable,
> non-critical errors (-ENOSPC, -EDQUOT, and -ENOMEM).
> 
> Thanks,
> Baokun

Hey Baokun, yes you are right I somehow misread the code:

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> > >    if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> > >      if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> > >        if (split_flag & EXT4_EXT_DATA_VALID1) {
> > > @@ -3304,7 +3323,7 @@ static int ext4_split_extent_at(handle_t *handle,
> > >    ext4_ext_dirty(handle, inode, path + path->p_depth);
> > >    return err;
> > >   out:
> > > - ext4_ext_show_leaf(inode, path);
> > > + ext4_ext_show_leaf(inode, *ppath);
> > >    return err;
> > >   }
> > > -- 
> > > 2.39.2
> > > 
> -- 
> With Best Regards,
> Baokun Li
> 

