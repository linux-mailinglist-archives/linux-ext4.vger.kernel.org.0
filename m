Return-Path: <linux-ext4+bounces-13409-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLcfGf9Qemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13409-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4A7A783D
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF7630AC182
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96B371045;
	Wed, 28 Jan 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hPthuY4G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FA37105C
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623534; cv=none; b=fU6naW2XBnLEh21LWo7unlU1TfTSZ6Q78arYsbOqX/58RrfV3CLfMiJiqID+nTqr6QYOF6y1IY19lK8YdiilLhnUwWj/D4ZfUEH9E8SpFP75rjM89fKe+/SCGwAbpjtn9bJK8BQUXyru0LCGC6YQYrJB+TcHEn5C/OHn/fBGviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623534; c=relaxed/simple;
	bh=Qi9rV6amFZaR+XS7UeGzIaDXZBZ4K2v+KFRmcsd9tm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF+pwBq33aH/HYkgMMHD1GdzW6LDDqZixWuZzy7S7e00OrxFbN9kSSJXS2tDsi1Z1twVoaorBEwZY8sXhkhdGpBocEI4rjyCIcktOs5y15erMBb9t1QQzqYqhwv2EAsyz2OlbIfKsPBeqMtxEVB3jPcNWDNQ+5S5LApD0A1+HaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hPthuY4G; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5GBf028635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623518; bh=Bd0MsZi5z4ttEfhXH7vzk46pYu7HCNVKKBGjxqxVJN4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hPthuY4GbLccTt9f8zJSCfZBaiQJZdwKqVCVy3fmnybZwus2QBm2bidMWldExHttB
	 O8rqZDV4kvt+8PurKkWQZTpEu2rFEKx9QgFta/mNEGAKXynGrKSe8d8QI+AEJHdoSD
	 66jGJdlASxfLglkfdTBrVzl2yIsb/1F4nDQYBPmf8+ycAVT8CIaxJGuFtqo6a0PuT4
	 lUV6bX/BM+Gk7DzVtGu7RnCclN9kt6w4bMGdq87yK3LaOQsnk5UZTNVhc5RadAn5MQ
	 4zjSv4Msaul2Szl5/IOLFcIpKmQb6ndy6hPvLGfJQz8HUw2UYr8fevW6iJwEuspFtJ
	 dLH12RnuDe5Qg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 11D642E00DC; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Baolin Liu <liubaolin12138@163.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: Remove redundant NULL check after __GFP_NOFAIL
Date: Wed, 28 Jan 2026 13:05:02 -0500
Message-ID: <176962347639.1138505.9928374064740899868.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106062016.154573-1-liubaolin12138@163.com>
References: <20260106062016.154573-1-liubaolin12138@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13409-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[dilger.ca,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DE4A7A783D
X-Rspamd-Action: no action


On Tue, 06 Jan 2026 14:20:16 +0800, Baolin Liu wrote:
> Remove redundant NULL check after kcalloc() with GFP_NOFS | __GFP_NOFAIL.
> 
> 

Applied, thanks!

[1/1] ext4: Remove redundant NULL check after __GFP_NOFAIL
      commit: 591a4ab9b8b125bf72a345ca6f5c0ee4481db02b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

