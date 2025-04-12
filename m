Return-Path: <linux-ext4+bounces-7218-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E68A87039
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 01:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA29D176361
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4622FF33;
	Sat, 12 Apr 2025 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U/C+ckdc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B038385
	for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744499579; cv=none; b=u5kgVOWpdBptKgg/AqWO0O9zRcUGZdFfBY/Gxw8sll6mTIppcMm6ZNS8dJdZSmA7LNIiy35HWe1uCKll/FlGy5q3Voac5r5rs6vl2MDU3sU2e73fYlYsWDKHjx1e9gs+jnZW0yonxnW0kf5yR2YFDHehAWFc/4cvsTz7fOL/mBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744499579; c=relaxed/simple;
	bh=erErZ5IWo7k/p9GhH7CXHkyC+Mrxu7hz35nBRVmyQ94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE8EVZLS6Lb8ddXIO3swisH1V6HkfHg+XtonpOxR7eCC5CT2XloAJeOJb42TI2wtkkJWH48yPu4iLuMF4XTb79P/ODo/igEmfpirXQKVa4wgojkQPrNjsl6vNruBY13hy5AEoof/NLY2JvbMPg+nSYdiWMCG21VCgmzjb/FAMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U/C+ckdc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso608835766b.1
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744499574; x=1745104374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzVk3Vfm0xN6fR9iJk/fZ+HRS66Ighe4iqo3hM0TvD8=;
        b=U/C+ckdchtSaUbmAH8+RvUY+5ttLoVMuuMjvxuXnXbsMkwtOEuGmQIpqGzefMtEQDm
         aTRarfodf9K84Nmqa7QnrtWFX+v+hWA57yJfJlm5NExPH3zkKbGSgnK2Oz5Yc5B9kusD
         RGhjyhlEqQR+g3vjVqY6xL0nOl6+qlqIigbK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744499574; x=1745104374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzVk3Vfm0xN6fR9iJk/fZ+HRS66Ighe4iqo3hM0TvD8=;
        b=u037VdqGGEeX0MmfpYowg293CqsPr/3pTKMm3BhmGBTbjYuTQ7qJhwiXFM0QLYaV8G
         at5zHqoRvXUoTrFUxie1D8IxncJGbHpNGExMGOstPVnb54+/66J2EiAbBplEFOcKxEYB
         3iGv3FKy7NPM9ha2o5pQPU/jLBKP2xDCxNvRJQZs93Ah6oG5Kyh2/3LuACzRK3LAKLpo
         n4n8DGBgJMIET43WUgsd617/iRaAOK2edzNgeNEy3TIVAipurlxKbq03Hp/Smw4llz8H
         cTZS17IIAf8eJpgZ2SzWjxNqEXhVnR2qPdhiYIhQPFaIhOfjnwRJSUXov61ewwddLlBS
         xHWg==
X-Forwarded-Encrypted: i=1; AJvYcCUTl12CIRntNbvSb6119c+o3MmlQrQAKSSzQKB+iswTbG7Mj2a8bwZ4Dapp5IjN74L4Ts56x/nFk9zY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QiSn/+Ql25KmV6TUrI3Ran+9MljT/GkDvzdRju1xgawuVbN3
	PwPIggwFUnuAGRLiCdBrJR1Htakq+oK1WgYVRNTIiEhmSE7ENEyXVSI35QMAumm6jKnNTxf5rgt
	eNsc=
X-Gm-Gg: ASbGncuh5BzCiyycSYDbWt9BRTuRwKwJ0zVCQ9zXWdktNl0Zk6NKOGjrXXf5kOTFgEw
	mMRFIAPuC7JiAb9EY570c4nXBqSFMeONPGQyiB2YifCP9yWR9t9WcPFdhNcd4j/KYtrqfMrqS9E
	vKZ+0pTgTTOlVdUfbpPDmCLUn91pHvQYzWzxEfaqXRHQgT/Vjupu2INlsUnjTq/lObvoZkFgnYw
	bgH7pu2s57QRxSeG5JAMYTxsfbWIzfRwuvvI1OXozgoXRp7S5LIui00oQKB3GmdwlH6/4Chxr60
	JbjgJsBt7OSwYTOSwTsr8Gt4ZHxH6kBej7dXOT030qiog5x0kwCBK3HagZec7mvsnoDfGXR7MkL
	Eo1u4sCtYNxw2Qi0=
X-Google-Smtp-Source: AGHT+IHPdZC8miWaHV+3O12LQP2PCMPJeFbRYoMhg8uPj0V8Pz4+MIhpdow9Buz7tmuLnCPqYgRkVA==
X-Received: by 2002:a17:907:1b22:b0:ac1:f002:d85d with SMTP id a640c23a62f3a-acad3457ccbmr611445266b.6.1744499574356;
        Sat, 12 Apr 2025 16:12:54 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc141sm665617666b.144.2025.04.12.16.12.53
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 16:12:53 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso615630666b.0
        for <linux-ext4@vger.kernel.org>; Sat, 12 Apr 2025 16:12:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbhQxZT5xsn2wvybtxJ8TFmM5eKElPTEBMFlzQiMUStBuvd+rGxXGjX53DfJdNDl8/1Me8KitvGZpU@vger.kernel.org
X-Received: by 2002:a17:907:3e0b:b0:ac2:dc00:b34d with SMTP id
 a640c23a62f3a-acad36d943bmr647780666b.53.1744499572869; Sat, 12 Apr 2025
 16:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
In-Reply-To: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 16:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAi-La-PaktC83QhMWXyE4v3u6mzPwpE0bX7jhtRaitg@mail.gmail.com>
X-Gm-Features: ATxdqUGBBgcp2Yt3W7EErIVkfyH75cMOpLdKjddWRCzYAf_XyWMHN29s807rB00
Message-ID: <CAHk-=whAi-La-PaktC83QhMWXyE4v3u6mzPwpE0bX7jhtRaitg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 15:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Indeed. I sent a query to the ext4 list (and I think you) about
> whether my test was even the right one.

.. I went back to my email archives, and it turns out that I _only_
sent it to you, not to the ext4 lists at all.

Oh well. It was this patch:

  --- a/fs/ext4/inode.c
  +++ b/fs/ext4/inode.c
  @@ -5011,6 +5011,11 @@ struct inode *__ext4_iget(...
        }

        brelse(iloc.bh);
  +
  +     /* Initialize the "no ACL's" state for the simple cases */
  +     if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
  +             cache_no_acl(inode);
  +
        unlock_new_inode(inode);
        return inode;

and I think that's pretty much exactly the same patch as the one
Mateusz posted, just one line down (and the line numbers are different
because that patch was from five months ago and there's been some
unrelated changes since.

            Linus

