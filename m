Return-Path: <linux-ext4+bounces-1504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEF870BA9
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 21:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A2282192
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077CE8F6F;
	Mon,  4 Mar 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YyL723Uz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECCFBFC
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584496; cv=none; b=YzM/MSdUO04KCcodMpnRWL+c7GZf/JaRu/AcrUz3W+iBi3kpqfiu1Q60LOc7p0Emh3YvpIBVJRs6aabiQpJKA3W102OM8SrxuLox5DmTFfbG/tcmVQS+D1wV45IYW/LfIWO1camLkjSoN3qrvfECNKAI8T1lsBRuReTusXHNn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584496; c=relaxed/simple;
	bh=AISBuvAxGxZxAfFf+xblXWDfNNbPWO15tG1J3kLkqyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFBjhJEb8HjIY//fuZ4KAmetCljgOYmC3lipw546W91lz0jW4kD5GG0Oca7IEDlFW+D7nBouT+z1mPlwZnP2YouXlinw5l+yaYgCbE23/ANDkM6gVrfstVzT4Lkj9u2CfsnDLkwtXJGwh7CsoQroY7FzqAwmYV3qCP7e+fZS7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YyL723Uz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca160163dso47882555ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 04 Mar 2024 12:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709584494; x=1710189294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3svLmy1FnHxrRqHl7m9l07geCiZuJFO6G7O3eYWFJA=;
        b=YyL723UzjdzfDYC9NIe+ivSJwK0ndfWyuzDHme66MRo0y5FKFRdwgcfeQ78ve0qNYH
         rhw2+T9QFwc1UsslNWfoLiCAyH/U06y8roB7lopXBzccdQk9xXId2LxdwulobkLLEyCu
         AnMfsOoYgk1bAeBjr2AAXHvuGcqN3AySvVFL8PUx4IoVgNZ9saySd2tWkmJsLAL4SVCZ
         5cLYM0Q58Gf66pXHf1GjjYs/c+p9zzFb8aigGUqNrRp6jbjv8Xot6eC8qBrMuBM37Jbq
         j6Y8hrehUM5j43ookhsBGw/f+bkpOJ7Pdrayk+IzFzAdLK5KdkeD/DUinrWed7txOd05
         77KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584494; x=1710189294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3svLmy1FnHxrRqHl7m9l07geCiZuJFO6G7O3eYWFJA=;
        b=eWS48Iyn0EiC/YOuMsWKh5bJ+WeETIxruopPh5QMI1t4JNTG3db/wih/Z+NVwglxl1
         iCRvEkC6JNQQ/fOMYNuS35Vr4QLuI3EfuDPhRXALYdd80CvxKnmorA6BZrH+cHjPljoE
         5Tkk0KLujz7ees+XPDFvq0yq9NETYG8EgQ9iVRe8pdOSUvlG0pDckiWpefgJyvogW8QB
         I3iPoyJrVLn1d+0r654pFP6z6StiXlts5+aBmhNi3Zo374ZbsWeUf3/PMx7FGormr1+c
         dQdY8eBALDq1+pBbAhntO7bSSKfWAMQL0DZ96FAqvsHBKLpu3dKoQSCOLxhl4y6QO+CZ
         2ybg==
X-Forwarded-Encrypted: i=1; AJvYcCV7oE0OvDuoTt/ly+HSv370XeIcg5LnfxHp+o1/TdUrz6St4Rmw7ehhMiWnyuHl6GDg1gaLyoS8mz/3En19RisUm4CzkbNBO46osQ==
X-Gm-Message-State: AOJu0Yw8X70l5nnufydTRiYzJmXulqTwge0GphAG9qodnZ2ewZKWNGx9
	5YtNSW+ygeKJrrB5Vhl5KhSkqk8SzIiUT4iy91VwECUuOGqVSoopoKiM35MEvlM=
X-Google-Smtp-Source: AGHT+IFSMT+7ztEbdZ7fODCSLJxBXpFMUJCnFsGOgpZ0WCeytdIK4ZPKq2YbfAwhic1iFJ5tneFQXA==
X-Received: by 2002:a17:902:e744:b0:1dc:d722:4c08 with SMTP id p4-20020a170902e74400b001dcd7224c08mr14797300plf.5.1709584494412;
        Mon, 04 Mar 2024 12:34:54 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001dcfae01c63sm5126209plb.43.2024.03.04.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:34:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhF1O-00F3YH-2O;
	Tue, 05 Mar 2024 07:34:50 +1100
Date: Tue, 5 Mar 2024 07:34:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 6/8] ext4: Add an inode flag for atomic writes
Message-ID: <ZeYwavaG5WOJTFQ7@dread.disaster.area>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
 <33e9dc5cd81f85d86e3b2eb95df4f7831e4f96a6.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e9dc5cd81f85d86e3b2eb95df4f7831e4f96a6.1709361537.git.ritesh.list@gmail.com>

On Sat, Mar 02, 2024 at 01:12:03PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds an inode atomic writes flag to ext4
> (EXT4_ATOMICWRITES_FL which uses FS_ATOMICWRITES_FL flag).
> Also add support for setting of this flag via ioctl.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/ext4.h  |  6 ++++++
>  fs/ext4/ioctl.c | 11 +++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1d2bce26e616..aa7fff2d6f96 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -495,8 +495,12 @@ struct flex_groups {
>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>  /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
>  
> +#define EXT4_ATOMICWRITES_FL		FS_ATOMICWRITES_FL /* Inode supports atomic writes */
>  #define EXT4_DAX_FL			0x02000000 /* Inode is DAX */

Tying the on disk format to the kernel user API is a poor choice.
While the flag bits might have the same value, anything parsing the
on-disk format should not be required to include kernel syscall API
header files just to get all the on-disk format definitions it
needs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

