Return-Path: <linux-ext4+bounces-11497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDE8C3704E
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C0E5344225
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31D31A7FF;
	Wed,  5 Nov 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KsPg7zmt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2D258ED7;
	Wed,  5 Nov 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363115; cv=none; b=FQDjrBGCj5ILXNEFwydavfBv1nMQQI1XGPAVk1IyFd/oPQ1mWnWez3c+acvKsGc+goCzYTO3mBP3FZWNcQ/6A3vdDyENZ5obp8D6rJf2pyDsjRXVCxYbPDUPLpBfz8v3pwHfAhGqH2sL880GiCF39w14hkWCVa+UV3RZsk4ynX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363115; c=relaxed/simple;
	bh=wlsnHfA+JONe0SAzsEjECZPOVwINX8BTYXdbcfwm/JE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WMc/fy5IFw4yTBpEi0fefbGxfSsZS9VAUkzwrud5dpo5BeVzAc/LVlYr/nnrdS3YoWfGT/Vy+HH1DdIn29ivTOssVaP4gKXdB4Zypwf1AFB61XAjXZ6ATh1lY1RQd718YapQLFxhTiq9xmmz8BhWyNkYgNFO5ZR3vyy4YznOg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KsPg7zmt; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762363110; x=1762967910; i=markus.elfring@web.de;
	bh=wlsnHfA+JONe0SAzsEjECZPOVwINX8BTYXdbcfwm/JE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KsPg7zmtKkURJ4GShXc8EXmNsBTT8RDwqHXr2e5D34Ic2yxN+weqv85CgJSf+ilh
	 O9zF7Pb1sSnKX8j9onmo/oJHS0GWX/wcQMU0898ob+D2gtkLxsdgwPE+zOFyX/KyF
	 SKauW8b5LEaojZFFl/8q2Ildjc87gq/QYCJCRiyZDqUqLEDj2pj/24Pia79MXJXw+
	 bwt8i4lyND/yoHZI4/m3aHlGtsAAGtz6XVxb5vgBQTpowkjbUaHVDr5PsJb00HcXM
	 0FunnIiZ/HDUVv//UjHWfnH0hd+M+elASxV57/UYyFTZtpbcv/bBqWVou/62WG8x/
	 HyqVjhmXP1epxZ1gCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2kU-1vRkpq3Yqm-00EH3w; Wed, 05
 Nov 2025 18:18:30 +0100
Message-ID: <0a2942aa-4c82-444e-8eca-1991e6d15cf4@web.de>
Date: Wed, 5 Nov 2025 18:18:26 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Karina Yankevich <k.yankevich@omp.ru>, linux-ext4@vger.kernel.org,
 lvc-patches@linuxtesting.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Bhupesh Sharma <bhsharma@igalia.com>
References: <20251022093253.3546296-1-k.yankevich@omp.ru>
Subject: Re: [PATCH] ext4: xattr: fix null pointer deref in ext4_raw_inode()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251022093253.3546296-1-k.yankevich@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JnbQsZZdjQqa/Gh0OdJU+WrzOa7dh9lXmno4UHzkmUGAiqLQlyO
 aOOm+5LVrDelL+XVaZqRw9mcTDPQBSBYnCJ+ZA2YUkdg7oPmqySOMuQVFBKHsg8Lf0Y5/g8
 LUKF6x1wHc4wpaboI4eE+121TeHhocGXl0ztPvLr9YxYF7gVZkGxSi7WyNxY8qQcQIJl5eW
 rYheF67ElccDaSnraBmmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:88buiH7+Bdc=;s/dNBq70ITpgl7eC3PXJgNS4DrR
 NK+TeACB5flw1caCf24hgyMhEvVLfG10czJGsyom1vcRqO70S0+YrQheHZZ90nQsTQrIZQxU9
 wlUvqMlOXuaPdOxT0rQciy77jKUeTSN6ioi9KDcTnPOqSvS9KI3nGhEGBFZYIDt341KxPWGcD
 ns7M2fLvJoCbtOniWssYp1pY5G/ht/I3foXDO2ngOplV/wqGILFQCeQRfjMfbgfehYIehk5BN
 3acpbOMzv/kVvC/CyfMiztioXjDaQQ+966nGsg0ABrxJ99/VxyaQ+15JqxtzVLmnAbav1TByH
 2bmuCEhFt31ZtCbeVxv0YMr0u2eeHwH8ifpGynfrrmZ7vhpkFX2qMTNtkgSgbJ9ZsnRnVRK2S
 uLxPl8SSTJqxIKywHQXmC1zs2v5cCkvI+npn1HifpT7+KfaYqgDv6eiegRVqqoysbVPLCyHfM
 ESoKPSA9aDrNZ6FwycctaCSQI1cUnMRbbdOKV1mhLhRTnp8n6lZVfIw8ppXmsDFSEFiBRVLth
 udZeJbR+eaE2nE5NBaO62qKaLGJKOkF+5n8LvyDhZ6wcYT+hbkCXljsYYbRK3X2c/VKxZzo0j
 T5kC7zcTOwRkC5pVuSslG2g2CUr1b1olJiuqZwLhwoc49ARixtET+MsJe504sCihftZ8/DtJz
 H1lj3wwt5G9YnJX18Po1Sx8kNv+H4O14bazjHFjLNjYuIkf6Fpqa8+gk1Lkc2kfZoI6cXhy7S
 7FSZOyi7QUQuU9Ih50J2xdOAqj3plUDb4dq/n1jPLxD/HcMk6SDHL/8/UH6KuMrIi2iE22lYx
 nQhfuKIMDlqfT3S3/+NQUjbGSMff7us7TchWIG0X7VMELTUusMKr1hkekBWo77LtW8aLGs5nR
 xqGtYyWVv7EqPMJs8DR9r0Q7b9LjRjaebriu2d7D7HCaxy0d2N7CN063pyiGjSme0Nnuinf2e
 LD6PTXCAzSbnyavXFjqiTvxBY1EfOprQfR6yk38XHrwyK0twi/jwzYaJAiSugddT4YmHMzhlS
 PDL82sQqEDaSaaMHELQ8JOlV9aSPxkC8nf40ytsyqCb+W8n5GQnX/2iVVO6bi6lNumIrifDiU
 jiRnb150Ii70t2lBqfeTZkjprBh/KivoU7mDX/NiwI0c7jN+6Rfylq0/nzFbA9Rr+r8vlnt2c
 7REI1ZxE2qslakmTiqvtAK/75nmjfRoO0NYy3nV0KRWcdS9MBbV4T5mc0i3iqiKpsr5EE+ePx
 7Clp/zgKS9BBa9BybpXkFx4VDvAunu+uSCv2LHjnmxkqTY/XcIH1hzUon34n3GuUntwpk05hD
 kCjjiSsqHCOdHwfZyUfte7qTfMJI8nXJbOTK8crIn41q2QMcAGtGb3UF8PLQ/+8iCP6KN4RB5
 GBDNmqVg2fdggWsDbcHBqe9PspDy0NT0agfx0RONuGiDy9uZvUelaAJ7ErouSN4rwKMPQtFon
 +ymTH3d5U4rSBU6krR2ZWN9uzK8J8G5bBxw9cf8iOVI9HlX7HAqHoMQbcMFEC22kGovNhX4fp
 QQ+8c5bMAjch+bMaKbO2uDNVuh9EYOU/Vb/wzu9gkHNvunE4IP4wuSe9xHwGhDna65Dqjp3Eb
 GM66t8Fz1g6XqnWDCqVkWEYba20nBSKuFR6JoVJQIjvzMolnC8or3NRfvMSCrY3VEp5mpC9a1
 P+0AaTm5CeezWsWk9ZgiL+tpVtilOAftuXq7vkh11DHEFUZIuhBlRHNxH/+zwdD9uRyDtVWwB
 KU9ibjzojC2jhOiXJgtMsuuZGwnebl5GxoXJQarSKPLAPiZc0gb2YPtn1yaA5o1R0PSOQpQOs
 FBKf8Yag/7yhJh/FJdayEY3NEkseaVgcA0v7X7N1id0TtdBJDHh2pwCkciNrSmRko6N4X9oli
 0hbY3Uy00S04SJ/fKD98amqYrTHA9iAyXXuVfbakiSc1LpbjZYRBD0oVgPRw99RnLpfXDda+Z
 tgBTpZIRjFCRTzASnaf7JKxPP6sJ0QuyfX2qxC/RbwFp7Nv+mxubtOCf6A4ABwtg41jt2ME+B
 UAiCwwSea8FXswdP1xaRfeiymZjIe/SCGCAu7sj11aBCzNDdGYoTrYUTvmKCILYPd52jVJGX7
 CSulZu9Ggq7abHvJ3qjAvhvGXaMksLpc9wWURs4em2Cm0ncsfOutvpxtuQLyICKSXIcAQ/w5N
 qp8YkuJQ8LcITwYKE8m+j8Z1oOjxmEDOSxvmUGtWDxbUG5GTr5OcMVWXo2vVnKPgMZv5tNz/I
 ec6ohI964eKWo6bK4CbwRkP46obtSBTVhrXKS46fB4ZY5GhHwknF5JmavN4iTEdn+8N/U8xuc
 ecNTShyZb64qQPFfrq7liBh4mhNISXlN6Hyol/55T04MG6vsNiqBC7kSsfhBoXMeLPoCDnmpa
 V1KbqzxxpqCmv6hQYAfy4k0IhqrjCTLLF7x/TEBw21Ufw8rSTsKeN9iARGA8I1ND56M3tKdpw
 a2uTHmlkd6Pb0gvt0/ErDSEcQRYfDrP1mAE93uejI1T9LIfgu1E7CrDreZxDTz9s5zZZnh04Q
 Hk8b3pP8BqxCNAqv8ulm/wxrQp232JG+bV2egyCqsUBVi9P8qR38EkUuO6wNyFJYSOQtYT5y0
 JTXD8944DF7yoV2vsfEMy5jzA3bbsqdct3zulaIzJevW9Zn2APQjo0dNEI6VQP07jq6zqB26j
 yHTYTG4zj/p5nOBwfPn5rW9XqyA+3WRAWII7GDkYSOZSwAiwD+h7P1pntS/jZtjS3rMEmag0u
 0HeOOG/mQxdtS6bIMGU/5rwhrg0Nv0mdmPk2FHlMN5WCtltKNX3uaNaj8HU1ezhjLuKZQPx46
 QoUU5FCX4uNFn/SiSGSG5+WapVLHmaknBfOzLYn3DzleeBCij0pclI6KKNxNfoX+FQ0XuhYjb
 7kbzOl0f7OtoVTdZn4ro+CxanrAfuP1X9HIJV7qf6Ne7KhhPiBqWI2+gbseT+u24v1AWpo1HS
 D6egw5RtcuQPil/hk7+1hhr49Zgya6Fj2eDoFl8jy0dvPY27j4twdiSACL8OMYtTxA1s3LksB
 ETohDMUzyzUfm5aTZ/Ur9ggkkHdFRe3t7D5Kft+dq0bZ1zMgMCysOh5UCk5xN5QZ5LFdZZX6t
 0rr1QMzx2napyGt7jAfDF1kRvBC3YqAjwyQFV28JiXFnM+OtCfiUmKChP6F2DzVMvqw/8K/Bd
 VglTGLRlPiWQxxLxV9aLjc6pb7G897EudnRgUr3J3gcWnTcgH7yNoPZW8pqLeb0P6MkniigMZ
 N1YqFtwI1rgDejvy44UOo23NK4k5xn0rxNxhJLmKoSBPyZsGGQAmwFTLOaA566XYkqWMHqU8L
 CK2yubj3zzXOxUpAKiFIqzQUUOyGG32nCGQUPSsoUB53+uVv3h7dAytGJ1rg/A42zB5xz6PUJ
 rjI5whVuJJIipghY/EHOAMxhLmzwajUWiHQCBzozQdUO12uGbCkbFSD1hsXSsARssYOOqBh69
 K4yQnAN+R8UWDT0BZHi8hv49wmPvUA8bH5sb/VEKxsPTrAeCVoPSk6IW4CoVkezEQPORJetkf
 uu2GG7ZzA2Xc4DQqLFT0WD2aAlWexeT9xq2CnTfB8Qgv40oUxT5XMG+xvoXL9k73FMWW3AJXT
 MPxY/ecE0u9xS70r1mACJsAdI72b2LkOJrVZac9m+vzBFUJsPzl4GnLBsHHLdxnLio+xuuPHg
 oVs1lfWmElJqEPNBlfgKOoqT+R0J1BGd8/hRqvNDNCBOR3yDrBtXQadTtXa9A/v3jPmGDRWYd
 5Ps65bM5EoPx7htnHxvzRJduWBA3IlqdbIgWO/40BPhoD+mVo61mT7SAdYE1u/PSCZqyJNz3+
 usSPriMfFSFYXotK64W1FFclaD0LS1nbSEE6TgbWkbuKbViu+Jg3hLuaXaS72jaNNj8sKYiGO
 F7OhKKN+tw7YLSk0EuLjRf2cZWgK09W9ifW1gCtNYM5pY3BvE0RZA6l897VRdVnnQ/Dy+OCH6
 yaXvr6x9XPLeEeUpFj/90ZE3lDek2u2rneO87RmnmqFVkqirX4UC6c4z4UePo8j41hM0HWjkj
 wlFZLi7N9z/rnVhtNtYV7ZwGkuBq4h0msMyO1cRUJfZVhsjfU7Orbizf2kuJ8bP5fStwb9euV
 4N9QagDubiY8XJ4KehKgH8kE1L+FAilU+XadSZtIJHkdrEwtl1qwIPKW4M7NzH9WfAcb8ZsjD
 OA0aWD7tBMvT2GyWfTecFRO9E8j+kUQSFojhaOUr8i6HXL1YHKRfSrefnfrhKBMBnAzwKYlZD
 5bzp6O+uwX7TkRcEaPtJUdpTi54v879HtrYHZNq/0LzC8gwcjwBLep1oPGci0aSefuyZFgw17
 9Zf+KD/loIBzj0rqB1Pj8u0i+gA1K2n6C5lvmxypcchKG5kQQVWQxsvvGtr+kixptlW4XsuzF
 vccZJdBa4SVTJffOGBI4IbSiDvBRNHOUrtHbYNWT4voBehH9dYTFrvEuwEk4Gvwi8zwUxyV9y
 CghnYC7QMm9NFrQuRr36aVOiAQnDxsOi/KuBTgcgqJW1q8ytxXvOhuhjJLmCKNdAcLm5pBSRT
 RxAjc14SyH+0K6UehQUaYH8XggLAjWWYOdlxY+5yXNUxYD50VwW9DkC+XZqPx86j3RvRV9Mbb
 XbxxsBvGT2PCjIYbzO2eOm5QVO1q/lxjiDow4qRCSHqisog8K56UDP79XDMj0oiZs0270O4Vn
 wMXXkEJp3f+BpFj8GpO+Cm6KkrCzZrhU8HxEljbWigPJ9sKaR6L10LfFZVkWam9z5pBCjSOHx
 VdxIWrKPcQsYqewJiW5Dskz/bmEyqB3CKuHGQZNNT35YWkkbYVcDF/A33GB385yQsIQj8YXH6
 XR8aEqacZceP/7WmQpD+/694wanKris3yhyiR3vppllqGf6xDrip7Omwqq6jNc33PjgWJaDO5
 8q7mfqsT97+sRV+hk6O8m5yz5e7mBHh3I/8Jh0B8fF+FF3gLLJ2YZysN/JD1FmgWtmtzzzRdb
 7zps/8FS/5w10zs96G/mO+nwhHp3eRM436GU7MoAFvIL8txaFMvh0OC4kc6igFqsYo9/mMXxA
 Wc5gc5x8BvCG56Ra7zBSFrnRFQ=

> If ext4_get_inode_loc() fails (e.g. if it returns -EFSCORRUPTED),
=E2=80=A6

Corresponding error detection seems to be missing so far.

Would another imperative wording become helpful for an improved change des=
cription?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94

Regards,
Markus

