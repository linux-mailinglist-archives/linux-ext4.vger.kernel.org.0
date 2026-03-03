Return-Path: <linux-ext4+bounces-14551-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKVNKxjVpmnHWgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14551-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 13:33:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527781EF7D1
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0773F303135E
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913932F757;
	Tue,  3 Mar 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8dFu4S7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc5saU2E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B2335546
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541167; cv=pass; b=Car2WmoaKk3USOuac418Nkcvb861IHEriO20dbEb4IaOHrbN7VEAlTTPwyD8+f7N7oBYRt2VkICak6mdSP18VdaA3x2gCD+40b89nT8swPio1D+1coRDRf7PG4Tywl1ta+lB/lPD61ETGvzvK9sSKODFg7f3qWwoKW/aMe9GuYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541167; c=relaxed/simple;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMWTPRG9qd3sx5P7lLHWHjB2QkaFtL2rTj9hB77EBjZMUuZ45wEaA9TNTeSYrAotkOPbmlZnP2qi9E4YOEKPsB8nHNV7YgECNFdS7ydVPfovTLnd6gn+mpUGS+lQaYCU6t4Fq/Z4LPaEbJU27WHjMJEYIhpD6lLw2rZLH44Wiz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8dFu4S7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc5saU2E; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	b=a8dFu4S7JefFGS+0kKamr7Vu2juHCbECEOM4LvUK4KrsLOmKKIQvnGTMf8pDGksBOPIUVy
	wHvV7cZaxrillKvA+VZG/0cvGpNHc5SWpp7jLJu+WKMb/H2Ai1aCpNumQhHbd7jEGm/ZFs
	GiqZhLRFQGzAkdbuT81Vla6cLZUgYqw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-ikgtGgknO6OkeoNfEh4-Mg-1; Tue, 03 Mar 2026 07:32:43 -0500
X-MC-Unique: ikgtGgknO6OkeoNfEh4-Mg-1
X-Mimecast-MFC-AGG-ID: ikgtGgknO6OkeoNfEh4-Mg_1772541163
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7982c3b7da7so102837737b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 04:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772541163; cv=none;
        d=google.com; s=arc-20240605;
        b=R4WAwlxcokUyQHQwadL/r1lHoq47HZa2Fl9bLMBn9iTRCr5i0td5Gpd1z/vxkzvDQy
         WG9Paa6eFJszKx0YulMCtLJF/TpilEkWQ3zQohAu5q9oK0+ohu0EbdjG9PRsrIe5bZI7
         KG6umIRkltlSULf3yIM50S2z/Z3M76l6sE1Ev7F94GBnMHycN1liF8/3WFWNZyd4xw3M
         WPjb8UT/AHKxTLtpBhoBrBn9C9Q0tEw8dtw78BQg8pHlQn+L3n3qDAbPp15LIRlFEbWT
         vRQtOeBc0Z39Ip9AYQKo2yQkfA9suHiq/DCBpADRTyjJND8uI/Cfqk0RxPz9IADFl7sF
         aCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        fh=t+Ng8QwDMYvKckSDK7Hi1JY3+VwNhkK6oF3eKQEyUIU=;
        b=U5JbEZj3GZBavVT5mWFMAeAkjagTEuDAvX+ttHAZItyMN68DWhQpcUMAi4c3wF67NZ
         s6XjXR0evF6MquuZ/DqzQfDUNuSe7cGSQX5s+ky2AQy5NEuJac92Wx2Sc9d8GIIkp4h6
         jT8VP7q+rWhZmc/eGjgVOeVWvWtfvlKCSYy14ZBi14llnK8UNvAubyhxDMV7DJtzLGcz
         758VkbiTOC2IFhcOqm3g/L+WN3WZAzFTdYmYR96En2h2b0LLmCVkN+vRE1PDw6C36uu9
         rVvEFCmBu0tAAnHz4qOxLigKGe1ROrLKbyDpkiPAqC9mDJC8X+kehsk42AXMeKY4a4bA
         e17g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772541163; x=1773145963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        b=fc5saU2ElXfHNungKAKLATIvnTe+rHeKlCyQ9Q3llbs/2uiZ6ucv3eBvvngF0arfS8
         92mykTZDjnOFJrCjzc8xEsEIXcCZNqj1jSQM7RZtwZg/MlT1/0StgmKewpxyw+BsPkZz
         gcxnMza2u2ksQfavYm/49ubx0+GcfZ3g1R2CIMFn7B7wBD7401wexYjDkhR27vDddt1H
         qmdShPSaHEnk4NyM6kbTRn2u1R7/rsK1zNwguMYNpS+OMXm6NYk0vQsgeptOOdIibUTh
         NC1HFe+dVihSlk+6Fa8Q282J7bMnDe0RS0bdzA1oafkAJCm3JO5saTiFHtxP/3l5tBq2
         4GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541163; x=1773145963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        b=IlHwLwoP6YSBvNrm0LZ31OXDxtinE0A4lJP6ptWOqDgUEjAjFVXwsyyewyK7raHQl2
         VHDKwrUt44+aAbScdD28viYmq05pwcablqZ+rL8GNuo9ohwFRCdW4wKRScD810sPzaza
         Ao9G70M88U/oiG7jxpPKM8ifAuea+OBA2aw9TdLtsYKngNvhaPyaBTFU7QAebTAZHGMk
         txen8rRN2S+8+GhAbLBVbykLMCNcxGiQ0Rwuct8gMCI5BrllLwY6OGFbLJWVDzly80oI
         vVDuUusFP1WpNDXG9J6+TiQX12iaDJb8QRkG1VNp63zsFvHKWMIIHZIsCxXGEPB6mC5r
         9pCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOMIH8ephP/gq8I9WO9+wPU6/Elpo4BMo3V5eL2XqsJr9v/bRge6vCwWmGLnn11ym+yFt3IWZhVEtd@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUqVCRG2LCABXz1LaoSmfUqKnWLhLr6yO59We5JGTnaBpCuRO
	vVYCPJO1E4KVPVuQLiWw9o2TlfbWNUedvG1ko0+HlfMlmEPYlS0Vjxt5ViePnp9P/kk29NWyCbr
	d0xoJ6ajhANjo3b1pUuJ0RBWHKkJEatCsLR1HBxdgD0DgY1mxjEWpNDKp2THK8UVV7gO/yDArd+
	kKk55pOTGh7qJl/s/gr4rRpnuDkiEleiMK+N3TgdMmHF6ILSfZ
X-Gm-Gg: ATEYQzxRAb3jMf6Wj+tYAUm9oUO7JbeOouLiTIOUzgnzpC90H9CqZOGxiA78dCVvr3N
	okJz4uIQDn557FwltpMm0BOatQtanbCnDm2pMXlYHtKbisCl504uAxxDAcFYmT1xeEItanzvLUl
	BDfakb5/zbfvygUAlVlbBDSPN0OMFTFz9A+uu9wRiu27a1CpZyY0p2MIte74S1dQVnT2whJwZH4
	flPBYhNyOs1/OFLG8oQZQ9oQw2wAZpQv+gZ8E4ss/DBF7rYcbp7/YWmtNAO+ZEsmQ==
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id 00721157ae682-798855a41d7mr139268217b3.34.1772541163335;
        Tue, 03 Mar 2026 04:32:43 -0800 (PST)
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id
 00721157ae682-798855a41d7mr139267957b3.34.1772541162941; Tue, 03 Mar 2026
 04:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303101717.27224-1-jack@suse.cz> <20260303103406.4355-43-jack@suse.cz>
In-Reply-To: <20260303103406.4355-43-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Mar 2026 13:32:31 +0100
X-Gm-Features: AaiRm51g_TgIhOkGLCDR-668UB9OmDW-WHgYo8dNTw7KZZwkVFcUvPwu-AmQRn4
Message-ID: <CAHc6FU61tUwnFf4pXWun_nLnL2jyUYHLKAN7C1hanbKk0GTZMA@mail.gmail.com>
Subject: Re: [PATCH 11/32] gfs2: Don't zero i_private_data
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 527781EF7D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14551-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Jan,

On Tue, Mar 3, 2026 at 11:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> The zeroing is the only use within gfs2 so it is pointless.

"Remove the explicit zeroing of mapping->i_private_data since this
field is no longer used."

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


