Return-Path: <linux-ext4+bounces-13197-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBezONT5cWmvZwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13197-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 11:20:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8876524C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22ADF6675D1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39293BBA04;
	Thu, 22 Jan 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/n8wn6z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5S3K+5K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3D387572
	for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076800; cv=none; b=iCq032avZKHOMwLPsHcZeQvVX/fGbzU7RVs39fRoJTPpE3LXSPr5lHEY3kk2aMhbou8ueNHNfIdDC3cXUWHzex8B77nPIktja46b7ssrizFE5VOPzUhMXGXovOtQazPT3NbZSoNAqjGWNsBlciTBYL04Za9XlCh98Ijo3OOFm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076800; c=relaxed/simple;
	bh=+DaVDwDFTaE2CJY7NQbgkoOai3RZT+Zn59KkM8yLeo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byrv+/jgwCW0csnE4BNrqd653yQZh0V37ebs9SLhdP8ufcL0ezNnAljPm0yM7yUWWb/suhEWQ94d2Y2J4AZX5dEx0bM7s3U4xYa2i2pNevoWgw5JGIU7aAnZYfPyWQ0YXI3MPpF628xfqiZkOqacGuDGE58H4RlzqqHIMJoXAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/n8wn6z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5S3K+5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
	b=L/n8wn6zvIM0eC58IePL20TmnpsEyaxcGFlpDgJIgMLMk48B7gdgxepySwWv3gWOoZa371
	q0Hkwc696xHFd0iyH9q+VWVvjRA4nbHwemTpSXs+KXAafR2zXAEihIMgO1eGeYNOH4VhAK
	orCCylnfgejMI3uphcQk2shL2OhziBg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-hW0XzP7XN8W_srpBTFYDHg-1; Thu, 22 Jan 2026 05:13:14 -0500
X-MC-Unique: hW0XzP7XN8W_srpBTFYDHg-1
X-Mimecast-MFC-AGG-ID: hW0XzP7XN8W_srpBTFYDHg_1769076794
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso4986575e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076793; x=1769681593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
        b=g5S3K+5KE9TU90sCN1QAz80NYI66OosJyZHhY+7yAiUx1pPBL4tBu1PJdbZCUucOjE
         BzoWrZeGYy1ajTFZuepFHm2CenYr7g0MuhGf8oFDI5/4vD34Ka8NtNqtbeFBiJk73kT4
         bPe6nQmSaaPs1w6A/ghFYW1Eimk59akp55KoKXak5CKMcMwwBrDpHqIBSRLkg4bLKO0T
         r+X5GIkyiWABZOpIBv90hIWizH7D+CBox3zmKCeRWfniE3BhVuczFs9V7f0TyLXrJkXn
         xXtNbQmArNN2NWrlaONrnGeqP8LCZ9gTEiSIzYyW9zJc+aTA1ic/LxmXoEOLL8qpPOqT
         549w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076793; x=1769681593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
        b=lHB24KtlHHvZS6HBf0R/Fcb9ilrcq5dNrnDXG3xGPhP1kh++wMEojghvnTE7sEpSIR
         j3FoXLHpXx2hWrbpHv4l9gwFA+LjzEhWntrEg3VxEKcb2lVvPVZu1MibtYEVKMEOsyvX
         75zkbBIgs4jUAXw4e2F2DOLT1OuELn0PJzDlPvQlm+KVpoNnLbx7SbfEVvoy70WK0Qa8
         aSkU60ZOZnGxY0VMrlDCAOu7KDnh7RyRSq+DUW7II71xQtn1Fd2NGqIyBVBgarIAsgIV
         6qhyjbG+SUNMiM2ROOYgLZ1w2ZSCPWvNlku6hBkTimz3aLcU4nTbbTG0MMIXIR+MfdY8
         71+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1KqsEfY3Ivp66LDF/xrR5au+FjqFsqvywmryAvXW/lMBCH32VQq0UuU0gh8HhBnDznCC6vdWEPWBh@vger.kernel.org
X-Gm-Message-State: AOJu0YwIupr+unbe9yx0V4ov27+a1dI2r6cdRJhmevX6QjcI/r0n9RBI
	9eMBY4iIrPYTunYWYeSVVlPiW8+eT2wa5W7+YO8qA5rDljtVOKorvn9e4deXzq4HwvrrjzgHYTr
	AxGz61+DTwuO145m4RuqbulFBvvu9IgHMOhv1Flhfme0aePWNxVWn5Fp2mOL6xQ==
X-Gm-Gg: AZuq6aL6lqwRuWhpB5eC43f0CrNqOhFj6bEsoLYJW7TSlQbsfxg6Rj8wa9HgWRQpUsf
	aTKhTtDvYwTBLep+0exgvO8HT4hqjA4JPUT+79z9VmM1F4TF1e47c2NzV3alH0BkkyQmqcG3PxM
	MADPhJO5/7Pp/yIMh51gEZrFN5RNAax3iM/eeLbCILqWb+uOuT6p4zJ4YX5KORJzAGC3Z9fVTGV
	gcGitzyXrLDx9GRKvLTxBUC4iXq69lmvXPAWuw7FEuLXe83nom8GX4diHoQDjsn+1+Zw9kq2bGo
	6lrFvoz2N75wD3nNFVuLstYlBmSyTTGBMnwO9BSnDFHQlpQjddHFS/ONP7dS0B6rkkigFkVUvSA
	=
X-Received: by 2002:a05:600c:58d3:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-480470d4b5emr28224285e9.18.1769076792935;
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
X-Received: by 2002:a05:600c:58d3:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-480470d4b5emr28223915e9.18.1769076792425;
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804702fb04sm54550985e9.3.2026.01.22.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
Date: Thu, 22 Jan 2026 11:12:41 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <a3oh6pju5fuodkmhb42o5t7qkqo5oqtwk3nu4wls57p5ihz2rh@q7mt6lpuprvd>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13197-lists,linux-ext4=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D8876524C
X-Rspamd-Action: no action

On 2026-01-22 09:22:00, Christoph Hellwig wrote:
> ext4 and f2fs are largely using the same code to read a page full
> of Merkle tree blocks from the page cache, and the upcoming xfs
> fsverity support would add another copy.
> 
> Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
> this removes the previous f2fs-specific error injection, but otherwise
> the behavior remains unchanged.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


