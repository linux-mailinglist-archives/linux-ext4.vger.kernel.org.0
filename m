Return-Path: <linux-ext4+bounces-6846-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA7A6678B
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA6E7A5CAE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF017A2E0;
	Tue, 18 Mar 2025 03:41:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700462114
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269315; cv=none; b=CjGaJ9KOD3xcQtA3xd2iRkicUowwfdb8H0yLS16HRORXqhWTbAiegE1bq9829c0g0U07QRRyW7ay0fXDSqnT8G40uE/5rX0aN4eOAFFK+IOug6ZfXyT8XmWoOCbgvW53QXWZRICbB4bz0GbnVQ5ESyzqSddUEkvT180rtX1ncdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269315; c=relaxed/simple;
	bh=kza1B+G0sTvS3lu9twolLgJOmptZM4XnzqLGLHohiAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNHphUlqgd8VZDtmKUgbTRgUTa3E2VEhOG2bRPYwLB6v1TXI5Hnua8QWK+Rg/Lg8oPefMkbbBvyvjViIiwgXakw4dVPNZ/GSL+/ZOp9u6xyTQlvaXq3uZtMsyjwlVkTRHPnCIzstuzwe/nAqM+22PbHDVXvKBYvvWMDfmXgu54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3flhg012130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:47 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D5F542E0110; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] jbd2: Fix two annoyances in jbd2
Date: Mon, 17 Mar 2025 23:41:18 -0400
Message-ID: <174226639135.1025346.13664778450916411447.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205183930.12787-1-jack@suse.cz>
References: <20250205183930.12787-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Feb 2025 10:46:57 +0100, Jan Kara wrote:
> filesystem fuzzing of ocfs2 has revealed some issues in jbd2 where suitably
> corrupted fs can trigger issues in jbd2 - most notably a complaint about
> sb->s_sequence being 0 (which is actually correct after recent changes) and
> also attempt to replay the journal after it has been wiped. Fix them.
> 
> Honza
> 
> [...]

Applied, thanks!

[1/2] jbd2: Remove wrong sb->s_sequence check
      commit: e6eff39dd0fe4190c6146069cc16d160e71d1148
[2/2] jbd2: Do not try to recover wiped journal
      commit: a662f3c03b754e1f97a2781fa242e95bdb139798

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

