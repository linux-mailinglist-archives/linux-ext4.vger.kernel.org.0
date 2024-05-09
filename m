Return-Path: <linux-ext4+bounces-2416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1B8C10F7
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31681283E90
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460715ECFB;
	Thu,  9 May 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHhbdyKL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847116D9B4
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263649; cv=none; b=bUbOIP2KNnCLxqDRmv7TiXQbGeT/JKjKVeRcJBne0rGulcXp0U1k6Nak40ZvT9QMi1RfRa8cqCH1yDQHZazKLeiVzLK9BxhqeI/5QkUGBhogdxD7BTN152uuqluxNaF3GVDiE/nROcj4i2V/OsB7DaI5WVCizr0gnJy+ChGbRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263649; c=relaxed/simple;
	bh=JiFidWgVbo7lpqQfwmJAj0eW1ruWTPsb153Mm5x9pLE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ewf+R0jPHnQA/GD7xtbKx6FipkUJQYaVam8UvCR2fhjFYZLMnBuXFFTzAlECtqD2v0SHhwqUFsbB9IWvwYA3BPci47bIE8O2NB63UstTncQjV3TI3ZyhqBmfJYRT+ltODHnNtJY7xjRvpk/VKQJfMns5fWdkjs4Bsgv2nCh/oRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHhbdyKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715263646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiFidWgVbo7lpqQfwmJAj0eW1ruWTPsb153Mm5x9pLE=;
	b=HHhbdyKLAnczosDVK8g/asQtGAzYea5k+e1G8rBlmh88ukkSHLOv+HdyIXmAZCPQe5fxWU
	p90+SyXVWr0Gl1qEmRbgzwxQY24RxZFbmx+UrL0uNKLMN54O5R2/y+jmbT5JgrRpLwwQ3j
	nvcvDjru9AK094CgSPnWfvDlahtHuZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-UhHeasztPz2R59_V14Vzyw-1; Thu,
 09 May 2024 10:07:20 -0400
X-MC-Unique: UhHeasztPz2R59_V14Vzyw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 792063C0D7B4;
	Thu,  9 May 2024 14:07:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 202345AB8CC;
	Thu,  9 May 2024 14:07:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
References: <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com> <1553599.1715262072@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Jan Kara <jack@suse.com>, Christian Brauner <brauner@kernel.org>,
    linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1554508.1715263637.1@warthog.procyon.org.uk>
Date: Thu, 09 May 2024 15:07:17 +0100
Message-ID: <1554509.1715263637@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Miklos Szeredi <miklos@szeredi.hu> wrote:

> I think this should just be removed unconditionally, since the VFS now
> takes care of mode masking in vfs_prepare_mode().

That works for symlinks because the symlink path doesn't call it?

David


