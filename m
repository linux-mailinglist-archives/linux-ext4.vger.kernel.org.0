Return-Path: <linux-ext4+bounces-13278-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNL5NnV2c2kEwAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13278-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 14:24:05 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0976329
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FA64303A85E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53175301015;
	Fri, 23 Jan 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkoyQRiZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F342D8795
	for <linux-ext4@vger.kernel.org>; Fri, 23 Jan 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174602; cv=pass; b=WUw2GuLuFSAKTwfD4An8DTIVCSoWnERgmq182alAFZ9L53Kj9gQlyFp0Q8nf6wpL2I2GRhvShjtNrYZ7LIyLBssPpzzlxqfqL73tWL5N5U1ADAIoiO5HKUuzlZkgef++qLpnQUJ7/5YZLNtN25WVyTHbxZ+dFakSMgixqB2ISrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174602; c=relaxed/simple;
	bh=2yMX4KMIacTi5G1FaT6jVtT+6BVY1UFvsXDRT1eQCDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MWQOoQqUS9gE7/J4rleJrBwWaZSpr63rO83Sc7hwJ0OXwzzPqrt76odrAiiLKqrtkzt2y3IVqr6AhApFYx2avFteVynHqWttHX2Kq6koELdhlwhuZPyQ5I12fw51u0lvjYkWxEVRMjH8c6S2K6zGSrAB3Avj7o5yPT4bnsUfSkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkoyQRiZ; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eea31b5cb7so696542137.0
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jan 2026 05:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769174599; cv=none;
        d=google.com; s=arc-20240605;
        b=iJOhLA95E2pGeRVE8/qC5FfL4xSiXMVnxMmetk55Qx5NMJ0WMddUS35BYLSGnnCjPV
         Q5002OA8pJkjilkv5LIhpFx0JECEw6UvEhQjFT3lWGZqEXFy07Kh11OlpHsLi3HNlmZt
         ZaIjf1cNxdpvcNISM8QwiMq1qdqPWBb6QNFsbLZnFbvJSz5jemHsU7r8ttOVmOo0aDWg
         7IB5yKZxgnj0j60rVD0xPx49qfXi7WTpp9PByYoxzIICHhf4NoaBp78xmFBVDKk5/jrr
         kZx9b4GATpHiKTMVVvq4MteIJwp29VLzUoeyljv733TvRaG4ozKcoJ07uLVZyARlfYhW
         IXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        fh=hDQIBU42o8k3MxJCNFcYP1AiJuNP5Q6a1u9kFzxlCfY=;
        b=XCtq6Y2U7yHWrefGzs3uX2TtsKvhgJdoL+5QkEAHRuNfZP7+8cTVnIize5TF85gYQt
         0hGb8t5K2YoLtw3gD5zkdNprUiRDRfpjhrGPyaWxMEhmteXXllM4Q3I9vR87dG+WJdAR
         ggIOlrKvt/wPD+hYGs1WNaWAvOzzVqFCRpRXEyFXySvuuybGH2XuhJinX3WL6y4AeF3E
         4bY/UhmXsT1dx46QpSfK4OylmP7HIQNzypbOoD1EJPnyLS5SI9noE8Ggfy/KlUCvEaOV
         BlSy8sw6iJCUoHCuvKRWUiZ91l/x/eiyjCuX5AHINuAsDThamZgiJueCJVF/yuZK2BWx
         AV3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769174599; x=1769779399; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=NkoyQRiZO9++ahzHH1OJ5cCT3E2o0WVv3qA2Qem70FoCG8ghW61cHe4bSRBatgsOm5
         A9UVv1hPLOdqS7Om0j7zlcMFFBFxVAx1uBlswhWJlXn3OASJqKNdFhdsiFhkTqg9kX7H
         xjegM32LrT1LO+E+NmFwksOsoU/PioZNNfbxLms6YJ73QwTqql0xy6uHu8v6t5HbKdX1
         i9yLP0dUZ+jNxtpqiNPKX3OTx+CZM48wY44I/D/1o6pVuDZ/7wY+Jlkug/UcX9Oi+mCW
         OqBmRXD2GC/fp3HrUbK+h4svEPIprnXIEdwdawESvoKrh/ycipkVN9urALaU/ZPu6A9e
         gyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174599; x=1769779399;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an5pupjXgIQPeCf/UmDnIpSea/cRkdaOPzIbp8qXmEc=;
        b=eYKDHSg+ejnrj9nxzXNA2FjL6VJSUseQNy/fYDbqI3s4JMhDacBJSQAhxy4xt/Gvsc
         huFox8eOrK/vmw8CGaUPcF3oAu90wCpRGsdGbDx89nnFX68PC6dMJ+DTsBz9z18TUYuU
         OajmUHGfyDd+JBxu2gkz+eoEBnCwZnaf4JS98f9B46J6Cuj8xmG6EpNfad0wQgiVchbx
         aub+JJ+ofIHlCtZRlx0JbEZWbgF4C4BcJx2j0p5KLpKCLTw2L5CfT2W9QJCRFNUuFPUU
         nWzzuF4fB9FizA7E3S/LTWPUApGXWKDcVNutudtB6lHf2KTBwz837oUC6urNY7Bdw41+
         MJkw==
X-Forwarded-Encrypted: i=1; AJvYcCWiqj/QxKUQZZ4JHiLhlBV7MOQYC9zWNRoE1a8cu6dGRgLPZ9zXIaKenbBHzhYxnXNhquk7W2C8kShU@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrN9fXMg/3i+M0sojT2U5hSghRFCusDoUw93AM/qXAnmFf96A
	G78/XTtn9y7WfmdRa2qlisxDkLbpU3zP0Wew2sy5Jj2s5xG3pFgx2+HqscO3KoLpA9PubzlQ1/m
	Hum9HzsOKF0Nsbu6raNOepS5Vl+BIryQ=
X-Gm-Gg: AZuq6aKcMGADV72cx9Vf4GNrkzymiaz9kUeseGzUsjOnIA8xei2xAoxNmwi9nWb//0/
	fUIdAneiFM9WbDDUA2ruK8/+tllayPq/a89gsAxhI25+K5qcWnrjp8uRXIxcoI5+/xNY9emsntg
	Q3UghE4MzpJ61eaC9MBB+njVgN/N8IBBuhcmKAyBAhv7kxm8YoJJdi1pSnk6JvImTTazF8dmzzY
	LFjS7kjYhFuj+7XEv9yz8OEFUMCf4gN+32bv/cuTmC2t4Aj1I/eUVJEKlTZE1rMY23d4ek=
X-Received: by 2002:a05:6102:38cb:b0:5ef:7220:bca6 with SMTP id
 ada2fe7eead31-5f54bcbc2c0mr848495137.33.1769174599222; Fri, 23 Jan 2026
 05:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120142439.1821554-1-cel@kernel.org> <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
In-Reply-To: <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 23 Jan 2026 14:22:43 +0100
X-Gm-Features: AZwV_QjeaJNq0W-Cpcx_JErnCmrcMqvA53IgZ6NSy4KMyZ7YPDQ4CrxDdLy3saQ
Message-ID: <CALXu0Uc3gkrCmFApP1xswew9AmfotgZXR4uZXr_RetyEtC2pPA@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13278-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1C0976329
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 13:12, Christian Brauner <brauner@kernel.org> wrote:
>
> > Series based on v6.19-rc5.
>
> We're starting to cut it close even with the announced -rc8.
> So my current preference would be to wait for the 7.1 merge window.

My preference would be to move forward with 6.19 as a target, as there
are requests to have this in some distros using 6.x LTS kernels (Bosch
for example).

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

