Return-Path: <linux-ext4+bounces-13195-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA4bEvT3cWmvZwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13195-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 11:12:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D46510E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 11:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B12E7A3211
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4EB357A4E;
	Thu, 22 Jan 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWf8CMi7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l8Fbk2NH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1434D3A4
	for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076309; cv=none; b=r5I7PJ9uHJkELk5R89kclXzcrX3Vq+U/tCWR5uPa0BjljNMyCfL+JxzC04Gx9upjkUBctIbqobAq3zyHwyQGRM3Ghsnhj3iaEXYjBmsJOdEHbnhSLnSpK3YxtT8dmPZT7yy8uckS6nBHfG2nt6JFfOHRbLCxRNZdBUtK5ey/BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076309; c=relaxed/simple;
	bh=MRan9B0EEcK8gXicfj+D1fSVd5Gt317ZxAZHXGkA7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tchNCRBecYaEE0w4iteqsy2p4QJb9Y9qMrAgTmggbDbLQEhovrpHPFkIIw3VFZP200V5E2vBZnT/Y05BW30kvOWBIPiaLNRWkNisPc9ZR3ssQmTb396OO14QdFi6e9MWa4iuewKAAOwoIPLeBdkYhD0o4lrrv2CfNBxrAN9lNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWf8CMi7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l8Fbk2NH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
	b=XWf8CMi72NELo3h9CCYJe6airjNy8gH8lzXJiSPqO2Sh9VCBzFGjLHnMlNPSrhLXWFD72g
	bWbC11vmPKUscRUifPz8mF88PrwdRv5Dp5IvyfeOzjRc9cu2b4fdQkEJkQj3OOlQQWYoBx
	HrZrVhkuGWAoru6QNh5ddV/Fcw7pY0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-6xFWbeWjO6urjPbupoQmHw-1; Thu, 22 Jan 2026 05:05:05 -0500
X-MC-Unique: 6xFWbeWjO6urjPbupoQmHw-1
X-Mimecast-MFC-AGG-ID: 6xFWbeWjO6urjPbupoQmHw_1769076304
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801bceb317so7117395e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076304; x=1769681104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=l8Fbk2NHAO+bLmKfCIIxJ9zbILX8MfmbR4bRMD0/5lkKZ0LVIRNXdg1oUj8RZ5+Ivk
         67wqrLFWA41x/aodmdDUlqF1Nl0YsyZKmr/+ldGHwBBqVzG6f72WyuT0k7APYKCnLGk2
         ZHZO1OxaXPa2eLs79WBkKLBoabeFynrKF0+jsjyUie2YTOCw+U5Siidy1rOj8oX0u4Hp
         uHrwi7FQ02i8e/pTPUqCF7AUxNg82Smm/B1utPs7jxRvqbIkvM+1yemA6ohpbw8zy0Ax
         JVm0BcF6uAg3ijIuqOC0Sf7NJEIqPs5iWhGoQyMdB0OUl9CGwoYw8excKK+1rSa68GPn
         E/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076304; x=1769681104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=ZX3hNy4Tjs0uv3l1qsjPLKCQ1Gdz3JcvdZoWr1tWvU4rVAuEx0Fpn7xcSl8oKPRRbN
         XSXeBkiFMBRo65Q10v5zzyrOzX6ONtdmWXbG5eTZaeyTIS+hi1uAJmVZBPevTIq/jS9s
         7mz69Y8dE7Jt5dvhcZOSlTiIxpADx2C4O6Mq5fmQIiMwScIBWOoeZOAOdT20flJksKi4
         CQRKhilShQKuQnb2xtNEM2zfmXVdYN2f+sr9tAruKXezndwP2eiFcduAD8jbIUmf2Xzj
         N9WiZdql0KpF96LLqYmBSel0pb77VDWTnF7cqS+g7uFWKeQlu4b9+B/WcFlqsw5K9y8P
         5mvg==
X-Forwarded-Encrypted: i=1; AJvYcCUBTbshxHf7ZUqO3p73vZ15FptR1h/5rOjbHGFCHxwkrSzAvVeB9Le8OVAZymFf+H4+7I6oHn97r11c@vger.kernel.org
X-Gm-Message-State: AOJu0YySPMpGyPba80H34YboROwul1TBYsqvjPFDMNUhKSL2Iz5G3MWG
	ipOOlFqOJb1tzsHZWrkt0uhQKGJZkBpXfmIadGeSq8y6RsNAY2YC4gDoLbulOIkR/aU+FXy/+a3
	LUQ1T27L0SioxQIuIDdP7MDHEh1sQ/SeXYEgGJcW+NrmLImoW0FRYDDiD/4RhBw==
X-Gm-Gg: AZuq6aIAJJy+K59RlMGb7H9X58lH5qT5/OTD0NObsDtovOEN1disWUBTRwjuO0g4Owz
	5DSkZa8RCHwb2JdqJpQXDPaux4pmzIXFd1DrVNTX2pXGU1KV2lK+ILPySC30voo/9rkMhZC08T7
	Hup4dpKx1LGj1r9tZNzZfopUKB0v1mahTTyDw1jsTLt9rgmJmcUe/8/gUjKFd5hooikPNo1vfRS
	x95JI00+UAW5xSIzIWdAo3Aq+A7LIGaR41gIM4kZn6CKZ+AxsDFhP/1WSINgQtK9w5JdW+8OChI
	L0xNbSRtz+A/P/tqTZL0/clrDIlGnZzzk67pZvoaAZaW+d5xoR7jVzNPIrHlHfgD3K4cXnPblJA
	=
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935885e9.3.1769076304274;
        Thu, 22 Jan 2026 02:05:04 -0800 (PST)
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935225e9.3.1769076303635;
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704087asm53174235e9.6.2026.01.22.02.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Date: Thu, 22 Jan 2026 11:04:32 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/11] fsverity: pass struct file to
 ->write_merkle_tree_block
Message-ID: <2i3y4kybtm2lusa7eoutefawgrkhoqhuyquilu3qvkziyhpbvf@jeyk27glmeyg>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13195-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: EC0D46510E
X-Rspamd-Action: no action

On 2026-01-22 09:21:59, Christoph Hellwig wrote:
> This will make an iomap implementation of the method easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


