Return-Path: <linux-ext4+bounces-13621-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIvGGA+TiGkprgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13621-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 14:43:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1F108CD2
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EEAF300C9A9
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Feb 2026 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32829D280;
	Sun,  8 Feb 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7G0mvvL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6953BB44;
	Sun,  8 Feb 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558215; cv=none; b=I5m+D8REZioQmJAoTePV09B4D9u2TBNV5m3F7i4ulypU4d/i3SCViHqKaJh4t4ZVJ4Dj4SYu+bBufGWrPU8v+Mql0/hpdf4lNdL7OEx9nD/8qbqwxmXSfBQNevbSuDB2S8p7SYJgZyJUJZCoFR65uR7jkEa+9OA4eNkw9kkMJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558215; c=relaxed/simple;
	bh=JKWxMD70sNR/OlcpP/Dr8+iH/QVPPCxlLjSxygJ+jKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqYLliiKYtK3msuSmq1HJXCrQ3Jzgy6WcTFiEV/Qj8FGx1Tf173lNiQoWeaJVZlB2sGNVmTAedo1OPCeup4NBdohTg/CdA918z58U8MxmIvTtIdK8cHAgKauGGaEkShUBHfLFE2JbnnNbWhTPxkVj0qkKSSEkUC4VsCx0+oiKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7G0mvvL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770558215; x=1802094215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKWxMD70sNR/OlcpP/Dr8+iH/QVPPCxlLjSxygJ+jKQ=;
  b=T7G0mvvLp2cMI7LwPFXwiL3tFUM2UG0J7Wnu2pIX0o1Zh1hB+pkRcVmj
   z9JonmKE/3LISFZUseDl1FXiq/YR1juLO87cMdznp/uNc53faR+0Q2leQ
   ijcz81wEpxhua8frRbe8uBv+ytj//2Fm4PztEFobwHJBrdIOrTqKs1yGV
   aFtG76BrolLPHutUDqD0tOcQjJrTmzNpqsJxjl47scsEzH1GDU1GTGugl
   jmG4eIg9tuMquRB8vGixPACD8krKAyYsYdSG/RxbtAmewT/DK5Exspx03
   Zo4mO6vf4iT7X3z4je2OqTDWVAhdNffg78mWEGUnWFOD1DkXDg3Awh5D+
   g==;
X-CSE-ConnectionGUID: glC6H+p6TE+0/0paASj3fw==
X-CSE-MsgGUID: pUAduRAOToWyu4LueXZV2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82011948"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="82011948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:43:34 -0800
X-CSE-ConnectionGUID: jykhtvQlQhWyaEhJcrfB9g==
X-CSE-MsgGUID: NrFrNHROShatCu6Z9Uw6Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="215518552"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:43:32 -0800
Date: Sun, 8 Feb 2026 15:43:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	=?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: Reject on-disk mount options with missing
 NUL-terminator
Message-ID: <aYiTAqpUFsKAhulp@smile.fi.intel.com>
References: <20260206212654.work.035-kees@kernel.org>
 <20260206214502.GP7686@frogsfrogsfrogs>
 <202602061347.2046B806C5@keescook>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602061347.2046B806C5@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mit.edu,gmail.com,dilger.ca,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13621-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DCB1F108CD2
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:56:52PM -0800, Kees Cook wrote:
> On Fri, Feb 06, 2026 at 01:45:02PM -0800, Darrick J. Wong wrote:
> > On Fri, Feb 06, 2026 at 01:27:03PM -0800, Kees Cook wrote:
> > > When mounting an ext4 filesystem, the on-disk superblock's s_mount_opts
> > > field (which stores default mount options set via tune2fs) is read and
> > > parsed. Unlike userspace-provided mount options which are validated by
> > > the VFS layer before reaching the filesystem, the on-disk s_mount_opts
> > > is read directly from the disk buffer without NUL-termination validation.
> > > 
> > > The two option paths use the same parser but arrive differently:
> > > 
> > >   Userspace mount options:
> > >     VFS -> ext4_parse_param()
> > > 
> > >   On-disk default options:
> > >     parse_apply_sb_mount_options() -> parse_options() -> ext4_parse_param()
> > > 
> > > When s_mount_opts lacks NUL-termination, strscpy_pad()'s internal
> > > fortified strnlen() detects reading beyond the 64-byte field, triggering
> > > an Oops:
> > > 
> > >   strnlen: detected buffer overflow: 65 byte read of buffer size 64
> > >   WARNING: CPU: 0 PID: 179 at lib/string_helpers.c:1035 __fortify_report+0x5a/0x100
> > >   ...
> > >   Call Trace:
> > >    strnlen+0x71/0xa0 lib/string.c:155
> > >    sized_strscpy+0x48/0x2a0 lib/string.c:298
> > >    parse_apply_sb_mount_options+0x94/0x4a0 fs/ext4/super.c:2486
> > >    __ext4_fill_super+0x31d6/0x51b0 fs/ext4/super.c:5306
> > >    ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
> > >    get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
> > >    vfs_get_tree+0x8e/0x340 fs/super.c:1758
> > >    fc_mount fs/namespace.c:1199
> > >    do_new_mount fs/namespace.c:3718
> > >    path_mount+0x7b9/0x23a0 fs/namespace.c:4028
> > >    ...
> > > 
> > > Reject the mount with an error instead. While there is an existing similar
> > > check in the ioctl path (which validates userspace input before writing
> > > TO disk), this check validates data read FROM disk before parsing.
> > > 
> > > The painful history here is:
> > > 
> > > 8b67f04ab9de ("ext4: Add mount options in superblock")
> > >   s_mount_opts is created and treated as __nonstring: kstrndup is used to
> > >   make sure all 64 potential characters are available for use (i.e. up
> > >   to 65 bytes may be allocated).
> > > 
> > > 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> > >   Created ext4_tune_sb_params::mount_opts as 64 bytes in size but
> > >   incorrectly treated it and s_mount_opts as a C strings (it used
> > >   strscpy_pad() to copy between them).
> > > 
> > > 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
> > >   As a prerequisite to the ioctl treating s_mount_opts as a C string, this
> > >   attempted to switch to using strscpy_pad() with a 65 byte destination
> > >   for the case of an unterminated s_mount_opts. (But strscpy_pad() will
> > >   fail due to the over-read of s_mount_opts by strnlen().)
> > > 
> > > 3db63d2c2d1d ("ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()")
> > >   As a continuation of trying to solve the 64/65 mismatch, this started
> > >   enforcing a 63 character limit (i.e. 64 bytes total) to incoming values
> > >   from userspace to the ioctl API. (But did not check s_mount_opts coming
> > >   from disk.)
> > > 
> > > ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")
> > >   Notices the loud failures of strscpy_pad() introduced by 8ecb790ea8c3,
> > >   and attempted to silence them by making the destination 64 and rejecting
> > >   too-long strings from the on-disk copy of s_mount_opts, but didn't
> > >   actually solve it at all, since the problem was always the over-read
> > >   of the source seen by strnlen(). (Note that the report quoted in this
> > >   commit exactly matches the report today.)
> > 
> > Looking through the history of tune2fs, I see v1.42 has commit
> > 9a976ac732a7e9 ("tune2fs: Fix mount_opts handling"), which always set
> > byte 63 to a null, which implies that s_mount_opts is supposed to be a
> > 64-byte field that contains a null-terminated string.  It also doesn't
> > appear that slack space after the null terminator is set to any
> > particular value.
> 
> Okay, so the userspace side is treating it as a C string. Then ignore my
> "PATCH ALTERNATIVE" I just sent. ;)
> 
> > In e2fsprogs v1.41.13, commit 9345f02671fd39 ("tune2fs, debugfs,
> > libext2fs: Add support for ext4 default mount options") added the
> > ability to set s_mount_opts, and it rejects any string whose length
> > is greater than or equal to 64 bytes.  This validation is still in
> > place.
> 
> Great, thanks for tracking that down. That looks to be Dec 2010.
> 
> > My guess is that the ext4 code should go back to requiring a null
> > terminated string, and the __nonstring annotations dropped.
> 
> It does already; no __nonstring annotations currently exist for
> s_mount_opts. The trouble was that it was originally treated as
> effectively __nonstring between 8b67f04ab9de (v2.6.36, Oct 2010) and
> 04a91570ac67 (v6.18, Nov 2025).
> 
> > I guess the hard part is, were there any filesystems written out with a
> > 64-byte unterminated s_mount_opts?  It looks like 04a91570ac67 used
> > strscpy_pad to copy the string to the superblock and that function
> > always zero-terminates the destination, so perhaps we can stick with
> > "the ondisk superblock s_mount_opts is always a null terminated string"?
> 
> Yeah, if the userspace tools always wrote images with a NUL-terminated
> s_mount_opts, then it should be perfectly sane to reject mounts that
> don't follow that. (i.e. this patch.)

I agree with your patch, so here a couple of remarks:

- the questions you asked in the commit messages probably need to be replaced
with the summary of what Darrick said

- should the not NUL-terminated string be a fatal error? Maybe we can tell the user
that it's truncated and go on with it? Dunno (on the first glance this sounds better
from user perspective, but it may lead to a weird results if the cut string will be
parsed perfectly and give something dangerous to the data on the volume.

-- 
With Best Regards,
Andy Shevchenko



