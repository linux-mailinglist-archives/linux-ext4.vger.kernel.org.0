Return-Path: <linux-ext4+bounces-13681-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMb4MB+SjWl54QAAu9opvQ
	(envelope-from <linux-ext4+bounces-13681-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 09:41:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345312B750
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 09:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BEAF301C97B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B87E2B9A4;
	Thu, 12 Feb 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faAd35MR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu5FSjOi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259D17C21C
	for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770885661; cv=none; b=fPJFvEpHCZ28sP27V70LLQuCproQ2df5pqInltGNJEGKiRK2bULC0qJO2oELbk81XW7gwVKnOWIjMX+JiNEiUFIYndz5CW7nlg4ONdU+deL3E6W9X+gDwxo2kp03kd4CE8RgmbIuyQydoNUxTmGD2ECUTIy836FMBB0niwXtpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770885661; c=relaxed/simple;
	bh=cl938Ti4asykzJQfcH9dcu74Ycfktb4FZovTLe3ueao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM6FMHGOglax2Ne7QopHR5fkRl53dIuI7SLThU46O81FpJu1EVwI9/GJUQtMRJ4Pyoy+JD8REy+pREH4K0DS+WAH9LRKl76rzX9qhN4RJLHAmrLOieSTMSYta8YwFLe46mQDeCe577DyiESc7eWANFuXavgSS1Sm3Pp81f2rCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faAd35MR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu5FSjOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770885658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
	b=faAd35MRsKyV3cXeFpw88Fkmp65H10saq9Bg6GDjh2oaVJay8j8tlXnhgmBru912whtp3m
	vcGKMhM975RoZUiOT1+fgSI1WSvKQijRlEbYl2DnwpXm8AwSvpaf+KMqth0mg/Inpo38aW
	dvOYRUlqkL53Dywtr0w8GR31FvT8ciI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Qr38MbSrPZWnRyPeSv6Hqw-1; Thu, 12 Feb 2026 03:40:57 -0500
X-MC-Unique: Qr38MbSrPZWnRyPeSv6Hqw-1
X-Mimecast-MFC-AGG-ID: Qr38MbSrPZWnRyPeSv6Hqw_1770885656
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aadeb3dee4so142434115ad.2
        for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770885656; x=1771490456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
        b=bu5FSjOiUj99GO6dPtW8BuTAPaM8b7i4+uiRbFDZ9sSY1/9q2mR91QrA1giZmRsB+h
         azW7kviqd0COCBzFy8JPmcZabcSXgM4UqyRrguXTXBi+5CsVUuBpehhETLg5KwUX0n0O
         HFFoY5zScfqSbtf0BSs8dA4BsbDfA/zA6diml/WETkidpynYoxDh4KhoU1mrnYvEi7Tu
         atJysZkqQfAdStuJuEZGTMq7hy0lXapuDmDvr/MlNxuaQAKzpFQsK16LwvcBHi9MiLjp
         kreGKg9j5MZqyd603VOSDN9oR14uYWyCwUAfbc8C6oLL46FadmmaM/GPxoKZ8QSVoHUm
         LW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770885656; x=1771490456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL7NTSnX4xVSvnxCNOmwrKaXtUHlYFRCmkMorjX+mX4=;
        b=JSSqaRsMm2UN+F8Fo8Up9JXTm7fmo1nmhKuDRLY7+uV9xWsLpL+oNWi+qGIL2NTk/P
         lMIn2EwZfbpwLN5terdopeI+nwvSNH8S1X/a/yF29FQwMdrwgR/HkyAhlXj/0InHSF5Z
         xgOFMdZg9E9XkFJ4gzQVvp9mh5lxR0wbG9yMMVsvb13ZFk8FCGC+h2ryYfUupP7XWk7F
         YwhmMHgTL9W1FZugt35YXWNRr0gzWRX8SqQHXJOWcqQMJUFyC6FU5IWHYAh2R0m868C0
         uLCuPKiErJQWkJnXpalopxbpEh8znlD02V1D3dks3r5ZF5ZhqbkQXCaijzVaCuMGuEZS
         K0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50DI9Qxhu9ar30H4x4RAG1G0iiyghP0BB1REH8a6Wy9mkZNRCGpoPSRUPEN9GGmUw34uZPz5m3edW@vger.kernel.org
X-Gm-Message-State: AOJu0Yywb6EXGBjgRxnt2BsxlxsVq5pd1WZvbyC54JN4G9UVjLjmwPZW
	+sSCiYpC9hsboXx6sGW9JUrna9R4q5h01VfWdhz6Iqm6E8TMkrPt7K+UkQmHfpVqhcOKr5lLA43
	ku3ksZzM0qWTL1JMtLHpRDZs8fDPeMpMICE5s8dI/qw7GFUfnfVzvC7zkaKY5lE4=
X-Gm-Gg: AZuq6aIa2l3ZeBa2NLTLoKwI5zvah0UKZYXpnto8omX0Wq7QROR7NZpP+Wh790wPGiu
	T5uKgi4wtaHoCMi3AFb68ND8mXArCJ7uipN80XIJnoQlX7pqqS0TTG+HXvvThl6HGnBX+ASELNx
	/0uDyQvSUDwWcsXP8FAm5eLqoGgazD44Giy4bUmHkpnhRzsnhVPx1ELt3OQhQRg3g6e/0OMirS+
	CXrrnHHHDZ2w4OscDzMtyewbEWQ+qVNjDXbSEgvV/FwLJzvBjs9PIcHKYSCPRvgp+xvw+9EbuUn
	um00O98m2BTRtN4ECR+R3pas2oVt+aYIGmmTyCIlcCdJEwql3Xw5nbLrMfaRdjWrztn3PhMVuHd
	Pd1PArEmDtUoxzFiJ+bS9lh9UG4uPED8bqmvN7ICcCrN9ZEPO5l2YG07BY4qHyw==
X-Received: by 2002:a17:902:ef45:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab39b12efcmr18314245ad.49.1770885656184;
        Thu, 12 Feb 2026 00:40:56 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ab39b12efcmr18313965ad.49.1770885655690;
        Thu, 12 Feb 2026 00:40:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29965c27sm69782145ad.57.2026.02.12.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 00:40:55 -0800 (PST)
Date: Thu, 12 Feb 2026 16:40:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid failing shutdown tests without a journal
Message-ID: <20260212084050.uim52ck6zhffd5kl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111707.17132-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210111707.17132-1-jack@suse.cz>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-13681-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid]
X-Rspamd-Queue-Id: 4345312B750
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:20:17PM +0100, Jan Kara wrote:
> Hello,
> 
> this patch series adds requirement for metadata journalling to couple
> of tests using filesystem shutdown. After shutdown a filesystem without
> a journal is not guaranteed to be consistent and thus tests often fail.

Hi Jan,

This patchset makes sense to me, thanks for fixing them :)

Since you brought this up, I just tried to check all cases using _require_scratch_shutdown
but lack _require_metadata_journaling, I got this:

$ for f in `grep -rsnl _require_scratch_shutdown tests/`;do grep -q _require_metadata_journaling $f || echo $f;done
tests/ext4/051       <=== fixed by this patchset
tests/generic/050
tests/generic/461
tests/generic/474
tests/generic/536
tests/generic/599
tests/generic/622
tests/generic/635    <=== fixed by this patchset
tests/generic/646    <=== fixed by this patchset
tests/generic/705    <=== fixed by this patchset
tests/generic/722
tests/generic/730
tests/generic/737
tests/generic/775
tests/generic/778
tests/overlay/078
tests/overlay/087
tests/xfs/270
tests/xfs/546

g/050 tests ro mount, so it might not need _require_metadata_journaling.
g/461 doesn't care the fs consistency, so ignore it too.
g/730 looks like doesn't need _require_metadata_journaling.
overlay/087 looks like can ignore _require_metadata_journaling.

Others, include g/474, g/536, g/599, g/622, g/722, g/737, g/775, g/778, overlay/078
look like all need a journal fs.

About x/270 and x/546, if we don't suppose other fs would like to run
xfs cases, then xfs always support journal.

I initially considered calling _require_metadata_journaling directly inside
_require_scratch_shutdown. However, I decided against it because some cases might
only need the shutdown ioctl and don't strictly require a journal.

Does these make sense to you?

Thanks,
Zorro

> 
> 							Honza
> 


