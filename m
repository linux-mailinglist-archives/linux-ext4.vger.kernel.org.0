Return-Path: <linux-ext4+bounces-7447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D4A997BE
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D225A225E
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272128E5E8;
	Wed, 23 Apr 2025 18:21:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717728DEE6
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432471; cv=none; b=UTXK5Tb9WJacr+FBEqNrcIya3Oiic//a6ZcMR5z6RCVuvKT663L2Y4pz9Yf2ojAtcrnK2J1ww0F8d/f8lMI34ko00qcXsU4MwFugu8UVSnGyGTU034lcz0i2UTpUDQqalQRcLzKRWpAqlN6ki8BgtpoSxh6Uzc4SHaaWrUTMpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432471; c=relaxed/simple;
	bh=Fjq3beIRfZMl+TYLgKDIgBaBVl4VEGbQn6fBRLomcW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1c406yhxBdd7wo7spvnTTWndcDstIG3uknW/ROqUixtmFnLmZ7K9nAitNi34aF4ta+7Cvjel7A6lx3TTcIEUsjShhqk/G8UzF7B0nxTgGecRmVbzen88005PvH5CNCeJImvMeqHmcK/SNmWj0XdvYgktEvHTmeeT+eW1+rKVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53NIKd71005123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 14:20:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 530D02E00EB; Wed, 23 Apr 2025 14:20:39 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Make block validity check resistent to sb bh corruption
Date: Wed, 23 Apr 2025 14:20:33 -0400
Message-ID: <174543076504.1215499.7893481546772162865.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <0c06bc9ebfcd6ccfed84a36e79147bf45ff5adc1.1743142920.git.ojaswin@linux.ibm.com>
References: <0c06bc9ebfcd6ccfed84a36e79147bf45ff5adc1.1743142920.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 11:54:52 +0530, Ojaswin Mujoo wrote:
> Block validity checks need to be skipped in case they are called
> for journal blocks since they are part of system's protected
> zone.
> 
> Currently, this is done by checking inode->ino against
> sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
> buffer head. If someone modifies this underneath us then the
> s_journal_inum field might get corrupted. To prevent against this,
> change the check to directly compare the inode with journal->j_inode.
> 
> [...]

Applied, thanks!

[1/1] ext4: Make block validity check resistent to sb bh corruption
      commit: ccad447a3d331a239477c281533bacb585b54a98

(Apologies for sending this late; I've been dealing with a family
medical emergency.  In any case, the patch landed in v6.16-rc2.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

