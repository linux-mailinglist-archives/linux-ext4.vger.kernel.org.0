Return-Path: <linux-ext4+bounces-2930-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96145914069
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 04:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EDC1F21628
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9084C6C;
	Mon, 24 Jun 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4fKRgHJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UTSiuJx3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B4fKRgHJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UTSiuJx3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B754A31;
	Mon, 24 Jun 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195463; cv=none; b=fGRB6nXrRaIbafLp6vm1w4bGWbCsLZHXnmfLLWpMp7wdHbSepgmVYNcxzfc2j59YpjMnbIBCI1JvEXlxGxogNg6QICbLqniu4iFs9oFQkC14vHG/U9zuGE9Z91LkHlArgHF1XnLCVWEKP56/NJsykYwq7rMSSvmgSXG3mr0ShZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195463; c=relaxed/simple;
	bh=cNWdPm9/LN+wkX29ZgOl2cW7n59b9xax14Dp/kwHNJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYkIPjPqIDNNy86HgWZJi+3Ws+G4/zExyepcwdIum/Q4/WAZLap91MLebYcMCT0ifShtY9pCv3hgTDkV7wJ8LoIt45Gjxk2pB86hber+rLEOGvJFlmmOfBQE10ljgRnLaanYZ2t/CZsnMX9MuX+0rtXIF4kYsJ7wnh6Uc0dCFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4fKRgHJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UTSiuJx3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B4fKRgHJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UTSiuJx3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1B9E1F799;
	Mon, 24 Jun 2024 02:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719195459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubKnjLUKFsQWSrYoMTiiZmS6hrdM1mxAquGcseSW0Bw=;
	b=B4fKRgHJYM/57Uj4LVCUh+DQUapc6+TLooG17i8ufOTaiS2RxSnBvi0oJ/fNObYi/dBYK7
	QMow33ksx/JWU14IORAWbYxUe9bIvzTReqUTFO8pAtCnnPmUtG8GZ58iKR7amd61CF2B5+
	UK05lfo6lbekyHpqXbt66v/pNtByg78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719195459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubKnjLUKFsQWSrYoMTiiZmS6hrdM1mxAquGcseSW0Bw=;
	b=UTSiuJx38Ts905Pbi+DC0gA4FuPbVBrxpCELBx8SFk0YCfGf2sfIMMAV9qpl1QD5UYLre3
	mvvEHjOuJNAZ6PDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719195459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubKnjLUKFsQWSrYoMTiiZmS6hrdM1mxAquGcseSW0Bw=;
	b=B4fKRgHJYM/57Uj4LVCUh+DQUapc6+TLooG17i8ufOTaiS2RxSnBvi0oJ/fNObYi/dBYK7
	QMow33ksx/JWU14IORAWbYxUe9bIvzTReqUTFO8pAtCnnPmUtG8GZ58iKR7amd61CF2B5+
	UK05lfo6lbekyHpqXbt66v/pNtByg78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719195459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubKnjLUKFsQWSrYoMTiiZmS6hrdM1mxAquGcseSW0Bw=;
	b=UTSiuJx38Ts905Pbi+DC0gA4FuPbVBrxpCELBx8SFk0YCfGf2sfIMMAV9qpl1QD5UYLre3
	mvvEHjOuJNAZ6PDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6BD713797;
	Mon, 24 Jun 2024 02:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LXWHFUHXeGZoJAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 24 Jun 2024 02:17:37 +0000
Date: Mon, 24 Jun 2024 12:17:30 +1000
From: David Disseldorp <ddiss@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, "Theodore Ts'o"
 <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: mostly remove _supported_fs
Message-ID: <20240624121730.4d35b58a.ddiss@suse.de>
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Sun, 23 Jun 2024 14:10:29 +0200, Christoph Hellwig wrote:

> Hi Zorro,
> 
> this series improves generic/740 and then mostly removes _supported_fs
> as it's largely not needed.
> 
> The exceptions are the negative matches, which should probably be
> replaced with a new _exclude_fs helper, and the test/ext4 directly
> which is also run by magic for ext2 and ext3.  I'm not entirely sure
> what to do about it, but removing this magic and just adding small
> wrappers for ext2 and ext3 to run the ext4 tests would seem like
> the best idea to me.

This whole series looks good to me:
Reviewed-by: David Disseldorp <ddiss@suse.de>

There are many double-empty-lines following the patch 8/8 removals
(btrfs/014, btrfs/031, btrfs/192, btrfs/196, generic/004, etc.) but they
could be cleaned up on merge. Also, "# Modify as appropriate." would
make a good addition to your removal regex.

