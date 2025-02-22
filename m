Return-Path: <linux-ext4+bounces-6530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD71A40766
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766F43B6866
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57592080D5;
	Sat, 22 Feb 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0H/2caV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3B206F1A;
	Sat, 22 Feb 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220321; cv=none; b=cb179/tblFQmL5CRIU7ER8OIkA6O2pDcKQ6mLoBCgCwxOXdQ+e7Pt3k6RiQ4yondr8YCzmFutFOxKZXP01RXDpoRuijUkfMmg6nIhDx4nxBKHDVgOXHxo8mQ4oawFsF9ENrNrXITScSfTe39Ah8Vv6P+OL5u85pzm3MDEx/O6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220321; c=relaxed/simple;
	bh=EeDJju08iU1yyZYbMpu1u5CV0TLEVOfnS03nJGV+Qi4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qzf/0sW+02rJnHe0wcizBmRgif9bW+uIHpxqmgAfQuZ3CJsG/jOEEnvqkh7rUoQoDByd8pVlB52bZmWX/IDqFCYE94IwpVl1WpdMinTVGLj2Qtc9ePLxBffEb59vI2KBk0xJmW1cp2qvpnwQ6icQLU6VrFqj2HETxIoG7viABoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0H/2caV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e989edb6so81773505ad.1;
        Sat, 22 Feb 2025 02:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740220318; x=1740825118; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1O0dlsatzka8Rjn2bFVMo/J2mA85sw+K5Yl9fpzwSQ=;
        b=B0H/2caVTocLnAtbpGjjRE+hREgvBIZzcZ0aMCKwFJJnGc6pUMxgY56PxMavyvtwIQ
         ITdsEAJwnSnnrm5bMO2TLHP5oXlKxmMo8EyV5yhSAs3soAZ5apUn6D24h+4PBNT/PfCR
         5jSUVdxRaHtNMpvLujqnMKofw5BJBclb8xMP2LujAtVZFZJOqyfwm+cGyMXzdpiXOymM
         gXUN6TQLbMd07VCDnLe8YqlUfhrUScWH15vvbgrDP+1XDB7Dq4ZGtmAImRC4nEuOdDiS
         qjkteRla/lpQuHlSc2JDOD2BU2f4MQRXx70nHamznq6mCKSb9/xHP+a5b46dgN0qKtWe
         9IvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740220318; x=1740825118;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1O0dlsatzka8Rjn2bFVMo/J2mA85sw+K5Yl9fpzwSQ=;
        b=jQipNDak9j6OjnmxYh5WOTLi3dOpUdWh6nPoMM6ShUmIq6w/CG5tsTdywS5Qc1n3/n
         SIhySRCbZ29KglD0QRnsYX4MB+bgpke8bjFEmSJILhz8de7gkXDAg6f2Ol38zFq4ACX2
         bwcZ278UbE4nqwC0qCPEiwhSObYxThb46jQnMFekQAYmxUttNvFuuY/O73FFeY2Kpf9m
         MPjysl7d68wUwUymttwLk+7nnblJDMpyg1mxscFbg7U3xeMiNarZsLDpDro1Lv7LZXjz
         9etgqZ5yutZqlQbjYCxaeohknw/7YidzpYkXx+H/t3oiXmhoV2T0YaiQPSiq3nKQDppz
         7MJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJz1NoY+cbx2zNp9E8MJx6uec2U+a95XpaDgTRLZFHzXgTIWDXeBhNqXUuDbummgEwX5RFKhWI/Gdd3pmK@vger.kernel.org, AJvYcCWLPjdiLwiV7Jjz0JURY5OqYOwyKfykvCH8yQ/T2OD6aihVW3zfd9Z1S0MGNY/AuWT0zvlrE83GoIOG@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTkwJqabnOwgtrEd6+KCB3CbAIixU6Grtqz4E9sLFpmI7xh2f
	Qo4k7tn9duPpaHDlDwFJv+Mu+b2KWKkTBHSOHZvfUshjWUFhPgOjrohC96dg
X-Gm-Gg: ASbGncs4qcI37aCZM9smVobU2LhwR9wA3o5djh18pwsuvtyYHKWi/dYtRPOjReENMU6
	8MwEU0gYQ4j4S/DHZzFWVuRrd/YpKeOcDWiNC0p9u/JNDh1T1Dxd9t4gpM2eRjPMPdPzA7Jrk3O
	H8nTmTX4BB5PTUXRupWhygp/lHLTY802sQJCze/GcGfDPWVuY3hNNpBaWHvFuEyl3Ku7TMq4W1e
	dDPPK/qxIt40egEbOXVzom/1GRJ9RzoaYirw6Q+w+y2E4rmHAsQTenT2FGq96Q9V9+kovhkQ9m9
	lGkEJjg58MbrmiIiGw==
X-Google-Smtp-Source: AGHT+IGEwfJ0QjG7Cr3aFOSZd1YhkxzAeQkeX3PxMyzf9G0qhNgHb1G84ruTloNxlyWBwSq6lOJpDw==
X-Received: by 2002:a17:902:ce85:b0:21f:f3d:d533 with SMTP id d9443c01a7336-2219ff3354fmr86247825ad.2.1740220318152;
        Sat, 22 Feb 2025 02:31:58 -0800 (PST)
Received: from dw-tp ([171.76.82.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add21f2149fsm13478068a12.1.2025.02.22.02.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 02:31:57 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Make sb update interval tunable
In-Reply-To: <86b177b0b0a863362f11afa3fd835c5734e14ef7.1740212945.git.ojaswin@linux.ibm.com>
Date: Sat, 22 Feb 2025 15:02:39 +0530
Message-ID: <87y0xygw94.fsf@gmail.com>
References: <cover.1740212945.git.ojaswin@linux.ibm.com> <86b177b0b0a863362f11afa3fd835c5734e14ef7.1740212945.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Currently, outside error paths, we auto commit the super block after 1
> hour has passed and 16MB worth of updates have been written since last
> commit. This is a policy decision so make this tunable while keeping the
> defaults same. This is useful if user wants to tweak the superblock
> update behavior or for debugging the codepath by allowing to trigger it
> more frequently.
>
> We can now tweak the super block update using sb_update_sec and
> sb_update_kb files in /sys/fs/ext4/<dev>/


Agree that this could be useful as a tunable knob for various reasons
rather than being a hardcoded value within kernel. 

The patch also looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

