Return-Path: <linux-ext4+bounces-13765-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CZA/IV26mml1hQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13765-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 09:12:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C816E9E1
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 09:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 464FF300DA46
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024711E98EF;
	Sun, 22 Feb 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXE4btWs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6A1A304A
	for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771747929; cv=pass; b=XB7QZR6aP2FmaRLYQ0cL3SMkQCV0KFsCfIhf+AG34Kc5oNwUBEBb38Nb/+hgIc17mnPoXD3FAS0qtvNKLDBznALc/YSKPkd3JokwnwVc1MpKAVj5++MlLd8Ik+CwXylS2KL+hKnT0uyvRo+WgbaHN4LI1fJLCY6jNWpzCdALPig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771747929; c=relaxed/simple;
	bh=u4QkaqOHPdvqo4va5B239NNS0cvAoJ2a/Bp+dB/+qLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZPo2/UR1p3da3CBe0rky3IYYhhStc+U4ziPAHTkaMjBV4lzdT+I7Ramjk7BhefqdkT2emmVShf0D7KUT2aZ3cD/xE8Q/WYr2mZUIP+MksoqBEAdRoEeHKqjiwjI2qOcobXuYtT0icarPgGO/ABGw6KIEGe7oTpWOvXdkDMP1LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXE4btWs; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59de8155501so3291435e87.3
        for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 00:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771747927; cv=none;
        d=google.com; s=arc-20240605;
        b=MySl4TGHdQKUJ9Tmq4vnbyXQLWsPp0O2qvyiqgdCpyNDeaMAkwaRC7XOG6DVFlJtjp
         Bvbd3Pd8H83rCduZiB2+FbmNAOPtQzV5vu7W5mCaobVdalW+sT/GPGB7LrH/Gv9wdI+R
         kRC8I55kXcysAGL7fMHPtvzCr7q43CeNG22LpCTYheqXZOw10y+kCWY10U4ZVI2dUS3H
         Fc297enQYAW09eG2LtOrjCsXn/3BNwSE78odPqOwT5yVnMgbM5LwtDY8JiX11Be3jQV9
         X+Hd9eVQh2V37lGIch+JGkOrTeziYrOy9/+iLEeb0IrqVTKvUn4avfcM+xii9ndCSaLW
         6Ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u4QkaqOHPdvqo4va5B239NNS0cvAoJ2a/Bp+dB/+qLA=;
        fh=nGrjORDzVP5cOiW77BZJCoyT8O4KuQsDfzAQUAFQh6s=;
        b=LdMgr8ZJraluImOvQ6UR4NlCSlvGZSIsQh61UMr8ByPLDW5EfRRbojIdXJbIBlwyFe
         ENlIZ7kjmi7Un6iPA1jl9gNOTeV1E1SwaSruwQkiabJ9shTkOlKOyufMJHJXm893haFG
         kEIxhTAQwVggeG1kcfLErop8QP2zgagccbED2vuGA0xEBvSb1Ay/kvjAGDss4ejpc9mo
         2nP2ISixrncrpLv65oz64TwCGYX75wovF5FnP2qFcG3KMetwGJ5KY6z9naWMcG4hCyGQ
         XKr4SFgQQTS5QsD84HPyFV7AGjfaTCPXeQRfSiCYOhSG8kw4gcnO6H/Xzl4z7VcU29de
         96qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771747927; x=1772352727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4QkaqOHPdvqo4va5B239NNS0cvAoJ2a/Bp+dB/+qLA=;
        b=IXE4btWs7Cx5ZWFR18DrrTbKHJuhWO3qAIh55C89YBwDKC4ilpAV+lMJGdxj10Hchz
         u8EqcbtJm5MJSAUehjfOnSgE5EFn/kkEfiHWTbO780Ghk3MwGLikDopAxLDsBStJTY2K
         wzmYmtzjYqB+qp13vC8Zw8yKGS1uaj1z44+B4A6cYh+6BHIl/VYcRI1ajagCyGJT4lqy
         l7+QL6hgBxrzAVa4rp+axdefsKaP6b4lZN5LveDO04pU9F96WrF0gwecPb+/Cty+UWhP
         YX1tW9d30QXt5GwIUugVjVn8aHLvaugdpe44SUZ9DTYJKcsRnp9eDl35WtSsz3R1Hjo5
         yJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771747927; x=1772352727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4QkaqOHPdvqo4va5B239NNS0cvAoJ2a/Bp+dB/+qLA=;
        b=xDkJPweRjraD0wdVrnO7r5cE39nOOKKQW3fcYZwLw22ZyVAAzJ+nF+t4HeWnxtVYRC
         x/iIbD0eF0fo5FN5GT83g2YYzRRLJdD83qIdfbr8xezqkAq2UBxRBx6mMUEZtYnMUlw/
         7p8XI7Dk245W88+7MopfxV1YVg5zmb/Fm/C0BxhbhMvFhAA7KKV6q/5b4/raE/rGCBoF
         P2JXOExCbhbdubVJ/AHcV4Gt4O250FWJQlWjqsMCBO7UCkivKTIleWFjBaaN1cZt8gje
         bRb9EpKftIGaObE8ChfuSl37lrIBDC7ika2coKKO/pgF8NB4ITxT3ChSlkez9GnDLCna
         SmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXcqks6FZUZaSfy0z7XlS6aRQOBnkz60qs2G38d6517pN9sZp+zu9TO1WiATpIp3PeOkdf1HltdhCjd@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQY/IR+AWKp8t3XJiHx+uO64id7Vi4NRPB6iGxzxAQzMleAC3
	He3O+jEo88VTtXxbBqLcA4VV4ueDbs0JkeaSLm/dvdYfvyWyVoSn7ccOgxXsxN/ZRCq2paADmqB
	YEN4iPQ7i790ryPGoa6XtQfLQfSkN9Wc=
X-Gm-Gg: AZuq6aIZ/5Pdc6MI6IXJ4GLVJHxIgWf0KvNx4Iw89GFCotRKzqt3I1Yi3EG+8qLwBxN
	ZCrqIveQqD3MWPHSLPVEBfClT+JuG3dGW80pCtpgZ2BEACzu2QdgCYniqTdbc3RAUeTKVFW3VZV
	i2hkLM4hLas2eKdvTGcZl5fTvBSzRZOBRpfm6w1yQBzHER/S7+VqlVLb/nzSYWwqZpXJxsbgAGi
	/OhUaRY96dHdWz8vF6MN64ZBGEP+lJjxfyR/6xBHWKk34o2CBZFal++ocJXGL103KVmTXYQiif6
	hNzniLRqPg==
X-Received: by 2002:a05:6512:ba9:b0:59d:e018:5648 with SMTP id
 2adb3069b0e04-5a0ed8a2478mr1453692e87.32.1771747926404; Sun, 22 Feb 2026
 00:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207100148.724275-4-simon.weber.39@gmail.com> <20260213000720.GA2191@quark>
In-Reply-To: <20260213000720.GA2191@quark>
From: Simon Weber <simon.weber.39@gmail.com>
Date: Sun, 22 Feb 2026 09:11:55 +0100
X-Gm-Features: AaiRm51_j7j05yl9vvZ_Mp75T_Q87FB9UZ2dpbbhJ3UWbqz1YZar7aOneO7apJY
Message-ID: <CAM2C2RtuEnbOYSMmLGtfOBmFqPoGLZ3Ld32dTmzkKxchB90HPA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix journal credit check when setting fscrypt context
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, tahsin@google.com, 
	Anthony Durrer <anthonydev@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13765-lists,linux-ext4=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,google.com,fastmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonweber39@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53C816E9E1
X-Rspamd-Action: no action

Hi Eric,

thanks for your approval.

How do we continue from here? Do I have to resubmit a patch with the
typo fixed or can it just be fixed on the maintainer's side? If I
resubmit, I should include your Reviewed-by tag at the bottom,
correct?

Cheers,
Simon

