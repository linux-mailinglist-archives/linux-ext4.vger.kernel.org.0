Return-Path: <linux-ext4+bounces-6469-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF5A38F13
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D033188B1AD
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F91A9B4C;
	Mon, 17 Feb 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XS3e5zhk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397A19F115
	for <linux-ext4@vger.kernel.org>; Mon, 17 Feb 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831352; cv=none; b=BRXAbcqN3l3aNMeIjrhnOSW7Os0iRXGaiVKane8JpaeEyP/4+Di4Xcrf+TGUyncZj/Jr7qG9PmqsxdUm9Wp14OGmKBYVJunmB74uqsI0UASGM86ysGYFX46aImi3/fH+mmfJqe5DXpr0Ye1wp1SWo2IFxAwOiospxn5Ua8Un+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831352; c=relaxed/simple;
	bh=tiGSLMs0cfOD2R6DyTEDZg7JHzKY793vDrUifSZhHG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKX86onMUnt0gjnzI2Do7gfqWVjt4rzGqAYnGW7KkQ7K4xWfWwRc+aShQ0HXtubh5pdN9O6BCyfh2Cf8nW9DOlyFrLuwjDMt0sKc4y27CT7BAl6Vt28rx5VFZJXqi/tZvDhFBa3FtT0mhcG51peqgK+1UDzdYw1HpeX0g0uNgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XS3e5zhk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso86732645ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 17 Feb 2025 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739831349; x=1740436149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0dCyPtn/RNwGDNdmqIJozgGvpDBIZ/1Rg9UhGXNP2w=;
        b=XS3e5zhkyRLCgb2HIqHoLytXT09qPsszYdpqbUnv06jEvVHRiemknN1GNG9ARHCCi1
         nizaheMcqhzI6oFga0oqadEKWXQ+pKi4Kgwvxbt693n/JdhBfvWLLWExZ2OCYhIAPrxM
         ds4FynubLxmXvA7TtDSmRVcEFclZq+dV3mwdnjR45OJAL9OBUqFPhat3XXJy5DCm5yAq
         mwiSoIBZTxCixHOw7wSA17PdW4UNT8lY9WwuatjBbBbeL8OiwhkjfLuEAmKJUNlTJShN
         pkDi+P1t0afqis7Ix1b6GD7PIkybzMlAU4bcQhTVD+MW/8/nsYlik86xWtq6Y2MujGKk
         0wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739831349; x=1740436149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0dCyPtn/RNwGDNdmqIJozgGvpDBIZ/1Rg9UhGXNP2w=;
        b=okkF9GXvleL4tEkanghRwvlVzqwqBjl8G4hU3UVnUP75XvSwEKGjAVAz7XLkKVZW0x
         T+s68HmOoFL1Ird4UeYlmcTtPfwNAjZgijJ2WkjVUR7ibKOjVt0V1NsHZNvYetDKxFIJ
         pjYL2pHeSfuj4oXaEVvqA9fTlfNZLnzx4SF1uZKmCcMJPRt0xpz09nzDqlaRWl8qVVPp
         rg86/tFFwkRgyxAmn2PD/ogGwa3mSXqm5nUKpAJ6wf82h0TzZ3AMa/LpLx7Is4prJetA
         r/aY0huSlMinIFEks9AfjT47nfQ27N9FLrMa9dKSebNDThij3DmgcU0yiu94Y/6LX0GE
         nTNw==
X-Forwarded-Encrypted: i=1; AJvYcCWLxVGB+3GtCQhgK4ZCmWjOzMonsH5rUzpIQFkCQHZ8dxbVhKHyh4BfSiLi7bj/yMmCHNNzAUf40lDq@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB0F8c1lbj3hKFYws8QnTW6R9GSXDJioevgZLR0OOMSfsu8Wi
	z6da5aUL1pNV8ggOes5U4PFhRE4ZTnZPnYxapwEsRZJjau8OLD8ursymxbr/dsc=
X-Gm-Gg: ASbGncup7DR+wUhuE3HF5c2Qk/GBGjLUDg+nbYHme3HsgtBK0QUvW7oVq2KpYkmkzjr
	Hf0KtEUgnx0wsLHuyuW3OASoNALxQf2X1B0AIaSHcslTb1ZFfeoQ/dXV4m+4s7uM++CmDI7Gtfx
	iIY8rtPnKbYRH80f9REZb1aykR4CWJsGaYxfZ6UAnU3qtf5l3hRC4Vl1SEzXOnQs9W2bCikJO8s
	gjwuLWgG+uaT1IpfI9HuDQzWjgTElT/2kXSiCqZKZKmNkvnooyTWsV1ysnhG5MM0c5J/zoD2a8p
	rxXr9zyXpvC+6/KHqE7MEFE7JS7bUMwhP5XPuqnbmCrqi6lFpFKP+siyBluSx2Vg8EM=
X-Google-Smtp-Source: AGHT+IGP5rIz54g30tIU+OVmpyVDidpTBJehmNmoUnC6Bu3VUGAv2em/Nl0f9iSxQUbPOCb/udVMZg==
X-Received: by 2002:a17:902:e5d0:b0:220:d1c3:2511 with SMTP id d9443c01a7336-22104056848mr160751525ad.26.1739831349292;
        Mon, 17 Feb 2025 14:29:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537d0f2sm76777785ad.105.2025.02.17.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 14:29:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tk9bt-00000002Z2G-45mU;
	Tue, 18 Feb 2025 09:29:05 +1100
Date: Tue, 18 Feb 2025 09:29:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
Message-ID: <Z7O4MZ0xOpO_GTKE@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
 <Z60W2U8raqzRKYdy@dread.disaster.area>
 <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>
 <Z65o6nWxT00MaUrW@dread.disaster.area>
 <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8a4074-ae78-4ba2-9d8a-9e5e85437df5@gmail.com>

On Mon, Feb 17, 2025 at 10:18:48AM +0530, Nirjhar Roy (IBM) wrote:
> On 2/14/25 03:19, Dave Chinner wrote:
> > On Thu, Feb 13, 2025 at 03:30:50PM +0530, Nirjhar Roy (IBM) wrote:
> > > On 2/13/25 03:17, Dave Chinner wrote:
> > > > On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
> > Ok, so CONFIG_XFS_SUPPORT_V4=n is the correct behaviour (known mount
> > option, invalid configuration being asked for), and it is the
> > CONFIG_XFS_SUPPORT_V4=y behaviour that is broken.
> 
> Okay, so do you find this testcase (patch 3/3 xfs: Add a testcase to check
> remount with noattr2 on a v5 xfs) useful,

Not at this point in time, because xfs/189 is supposed to exercise
attr2/noattr2 mount/remount behaviour and take into account all the
weirdness of the historic mount behaviour.

Obviously, it is not detecting that this noattr2 remount behaviour
was broken, so that test needs fixing/additions.  Indeed, it's
probably important to understand why xfs/189 isn't detecting this
failure before going any further, right?

IMO, it is better to fix existing tests that exercise the behaviour
in question than it is to add a new test that covers just what the
old test missed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

