Return-Path: <linux-ext4+bounces-13407-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBnkAexQemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13407-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:09:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E90A782E
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A535C30A3526
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91D371070;
	Wed, 28 Jan 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fI3rTvBk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555936F436
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623533; cv=none; b=h2gUbAc/DU4QXF/+OydIVOOE0VFtR1rDRw5VOybiq1CT3luTebQZUdaOdV1DX0MJFz4YR3tFYDvjbtjlOqlfmvrtJjkyvLZCZosaDmdhoLUtvePqAso4f7nZtrjT4CVtktNVIMY44iy+9OJe5nLpYJD46Mf8DU3MyyZ2f1ehIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623533; c=relaxed/simple;
	bh=1U+OyrA8uwtaSnRUUyKK6K6swTf15aHMCftKLG3gCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZI3FYt9wmBTFwLFAg3DY3ZLu8x9l0M0ZL8IdN1v7v5+II89IJvHI8UV3A87ps23wYbfWU7DZOYmMRkBRkMx0ZGMx4bLpEHybYowwvxWPXLtKgyodqVjEPVqc2t94BHRtofevhWJwutM7vSrwDJAR526Q9bHmSiOJl3PTj4l/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fI3rTvBk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5I7g028688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623519; bh=gO6ZIXhMpvu536yECHMmwBUXlytoEedcVAAJq0J7vqk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fI3rTvBkVu80PWI145vzJuZeLtvmRT71uCehTqWgFj3UZwszJikunfRbsDA6xvIbm
	 SE/1wr82lm35NZPmJDmMbTInk/8+w/lHU4Gq+an5SY2V+pI1eDW3uj7VySfn07oEqm
	 cm01j4MLYddIpixRBaVSLDzrcz6FDrjI0VtWVkaqzqNFYGy62+Hux5WQLehuarXopF
	 xbdivPu4b7om4KvrfBsSF4kChEeYaWq6gc0ir1GSlDAwccbH36Pufqme+ql5QRKVcT
	 rv+SmtQ0oWzybr9zJC31p1tWScsjDPyuP/XOjBvr4hoPnLxTv4kX3ZtYHJwYN1vbLX
	 55ZjBVEcyGzcA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 14B0B2E00DD; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Baolin Liu <liubaolin12138@163.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2] ext4: add sysfs attribute err_report_sec to control s_err_report timer
Date: Wed, 28 Jan 2026 13:05:03 -0500
Message-ID: <176962347637.1138505.16069919738430336386.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211030256.28613-1-liubaolin12138@163.com>
References: <20251211030256.28613-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13407-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[dilger.ca,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 61E90A782E
X-Rspamd-Action: no action


On Thu, 11 Dec 2025 11:02:56 +0800, Baolin Liu wrote:
> Add a new sysfs attribute "err_report_sec" to control the s_err_report
> timer in ext4_sb_info. Writing '0' disables the timer, while writing
> a non-zero value enables the timer and sets the timeout in seconds.
> 
> 

Applied, thanks!

[1/1] ext4: add sysfs attribute err_report_sec to control s_err_report timer
      commit: d518215c27194486fe13136a8dbbbabeefb5c9b6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

