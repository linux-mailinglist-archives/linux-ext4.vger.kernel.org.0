Return-Path: <linux-ext4+bounces-6861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0495A6679F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E92619A3C2C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6B1D8DFE;
	Tue, 18 Mar 2025 03:42:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686661D0F5A
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269336; cv=none; b=nm/pT+XJDsM5PnTLcpzp44qXUkie5/vYQqWirVLkxbEkU/LfTMYNz563sRqPSJrMGh0yWZ70hPHQrkbUEBS8BpjUdre+r4yIqGKz3olWi9BwAbGJ1ANWVVKHnXZTSf8cF4NaT2sEzbCM3qWBXScJ2lTtVOj+J/98gMDFe6o2Ss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269336; c=relaxed/simple;
	bh=yy357oTBrx7rBB5s67K7o4s7AIZ375/lMXuhAXP/BYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V76w226B8/srGwPAT6yIS/cVwT9BlbubDkFPSp52nZeZ704A0PoszdjZ1rLidQnNOUJyTf08K2K8trnPUVBecyaj5lwwx8kWNOrwkKm5H5TUHGP9VEJWwt0rk0fJZ19QvRphp772DNX4cUZwJ44+IwSc9mvVZMyqKFbQCtGdMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjhF012113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C906B2E010B; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Bhupesh <bhupesh@igalia.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org, revest@google.com,
        adilger.kernel@dilger.ca, cascardo@igalia.com
Subject: Re: [PATCH v2 0/2] fs/ext4/xattr: Fix issues seen while deleting xattr inode(s)
Date: Mon, 17 Mar 2025 23:41:13 -0400
Message-ID: <174226639134.1025346.10423819005675734722.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250128082751.124948-1-bhupesh@igalia.com>
References: <20250128082751.124948-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Jan 2025 13:57:49 +0530, Bhupesh wrote:
> Changes since v1:
> ----------------
> - v1 can be seen here: https://lore.kernel.org/lkml/1dddb237-1460-8122-7caf-f0acd7c91b5c@igalia.com/T/
> - As suggested by Cascardo while reviewing v1, there are two
>   patches in v2:
>   [PATCH 1/2] Ignores xattr entries past the end entry.
>   [PATCH 2/2] Hold 'EXT4_I(inode)->xattr_sem' semaphore while deleting the inode.
> 
> [...]

Applied, thanks!

[1/2] fs/ext4/xattr: Ignore xattrs past end
      commit: c8e008b60492cf6fd31ef127aea6d02fd3d314cd
[2/2] fs/ext4/xattr: Check for 'xattr_sem' inside 'ext4_xattr_delete_inode'
      (dropped because it breaks ext4/026)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

