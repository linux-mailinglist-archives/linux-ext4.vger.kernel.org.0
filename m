Return-Path: <linux-ext4+bounces-10479-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A4BA8D73
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D357A193D
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD02FB0BC;
	Mon, 29 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GMm+Xk5u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458A27FB28
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140930; cv=none; b=tWO7jkn/rrYvEBsF4gUDFNyx4ZRUDcyXidOgpGc+YqFlhBbUFl8ndzo1APwReISEslWqNEsOatPo0g9xDq6/CHQMrUnk92TBj2Gg2wYIRW4ycpbkMN9BQZ1HXV8VxTsiWfg69jH2qi+LcYdcWVo9wIhvQfm1XcVBQlmh/2VnqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140930; c=relaxed/simple;
	bh=2xSC8xOw39PoqtomGifjqgDyJs1aI5Ke4Zv20+JI6q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo9tdNlg50iUCK/RZ2c8jWedtxE4q9jiL/JleL2acU89DdkzL/ojONj+B/UmtnBlccw3Vo/cBaV2vhEdu7Tg6Dgv/6VvaqZIeSjeZ1eoNMj9PV2sAutZDLcxmMX8+zXFNpQct0u36bYuCsRDYX/tlVae//dpe51FlgHOg2xkrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GMm+Xk5u; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4265333f8f.3
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759140926; x=1759745726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ7ANp4feSsM3nr9F6qlr3qgsjhlMNU0LNT+QvpHtqI=;
        b=GMm+Xk5uhGTizPNNSpaq4pOWCEYefImCKoSK3IwJoO0iL5TzYdrCIyanKIjmOxB4sm
         Jtr9f3a9hl4UkS1oQaP5zBJD0XeHfcrBIXcte2+7kxbFLBnHXaQVU55Dk6knbmyWDZrg
         66iHA7UIiZv16TEpmJdIN+peehQg4xP5KuN+AHWVHe7zvHuBAzz6/swZhvAKVuZkUTPi
         D0quJbt4YYRdc8lPNhHcY+b1S13v+rBGGp6ECXLzTclwnRepYhfsb5RJ6+QhFPylmQcz
         vP3pmNrhUPzEs7BUhf/wje0aUBjwc1l6yUIyBG8znAATyFno3IJFWT1L+Te6MnNYPKyH
         EAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140926; x=1759745726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ7ANp4feSsM3nr9F6qlr3qgsjhlMNU0LNT+QvpHtqI=;
        b=O4m0AcRWzK5sCr1Q4E7CqWP2wUBhis4ggy4wlAA3M1pNbKSC1rsjKJJSzGenVdzCAL
         9NT485N5NXFgDfybBS9G2o61ZbY4jWl8WbeqELsLvQNo7m8vp8qbl35TptSVQszz+qf9
         +DMuv/YCSrDueNh+AvOfXToGXEwr4vEik+3iv3DBRSUN9oX3cc2FpmTqiyjh+pDyJqph
         MTI3aF7/DKyR1kkgtJlHsC/4iJaeIG4PA3mqV/mDOgVhpTgPRWTMFRHmGBwroNl62d/F
         4zEm3Rq/SDaTx8Yt7w0ob+rB2aF0bERM0rt+E9Adg9nvB/wwXbsDjVPaKwaSpRT8hnYI
         1rIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6e+D9vtENkeeZe/xFf+OoAgCsWd6XFlpJPZELVW5kmXdrBqYXTGEYIPXo/0aBiKLBrad7LOHUVW1C@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdikYHI5hPMZ0jU4vnl11ApUc8QekSUUD455l/cB0hy3oytZQ
	m0XQR4d2teWEyYSj+Wg89suo8MXY2MT9dNYZgF+P4dcpB2eP2YQL0I4gr5GGWhJyUYE=
X-Gm-Gg: ASbGncsuOSGOZu7LbkEEJiIUuCraLqVe+CVY71vNhUTeUWqoX9rw2NCp+JkORfVASFL
	NBL4OU8hvZEnr7+L+l5bRkaKcQTuepy9Z2vVyOJwzY/as6F0IsvK55/bUNrRM8+54GfZPMwhfS8
	7qOecM/veEPudQb1vxuHw1XoOeSVffDMsnHuoyghZyvlfbMq4Qb9Y0pxDJhueO0zbU7BsgpN3yz
	0ttvnnZx56vBRj78eI5eTq4xVim/6zd95+mxzHdNhpi0DuSXee0iVKQHL0m+wrQT1/FVc/mscNK
	IPO9Gl/J1J4YobGk/goWS289EM9NODUa8BJ9awj/AOk0htC9xy1Bw+6NvOrYynb/lCm+jJXb7kt
	PqUKEQYROSkdf2aWdet5Q9u3eIdFU5M6mX6rGTLIU948yiJnaSFBvhtsEcrrWXg==
X-Google-Smtp-Source: AGHT+IGwTABp0W8HTZ2uL4D0fPeCysmK0pZooV1lhBdIbr6aucHS3wGZOHDl4iox0FoIORnkSbDjGg==
X-Received: by 2002:a05:6000:2907:b0:3f7:b7ac:f3aa with SMTP id ffacd0b85a97d-40e4b850bc6mr14254003f8f.29.1759140926337;
        Mon, 29 Sep 2025 03:15:26 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821d3sm126868845ad.83.2025.09.29.03.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:15:25 -0700 (PDT)
Message-ID: <f8cf2061-44f3-4775-b321-713dc90c3282@suse.com>
Date: Mon, 29 Sep 2025 19:45:18 +0930
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Make wbc_to_tag() extern and use it in fs.
To: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, xiubli@redhat.com, idryomov@gmail.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, willy@infradead.org, jack@suse.cz, brauner@kernel.org,
 agruenba@redhat.com
References: <20250929095544.308392-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250929095544.308392-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/29 19:25, Julian Sun 写道:
> The logic in wbc_to_tag() is widely used in file systems, so modify this
> function to be extern and use it in file systems.
> 
> This patch has only passed compilation tests, but it should be fine.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> ---
>   fs/btrfs/extent_io.c      | 5 +----
>   fs/ceph/addr.c            | 6 +-----
>   fs/ext4/inode.c           | 5 +----
>   fs/f2fs/data.c            | 5 +----
>   fs/gfs2/aops.c            | 5 +----
>   include/linux/writeback.h | 1 +
>   mm/page-writeback.c       | 2 +-
>   7 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b21cb72835cc..0fea58287175 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2390,10 +2390,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
>   			       &BTRFS_I(inode)->runtime_flags))
>   		wbc->tagged_writepages = 1;
>   
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   retry:
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>   		tag_pages_for_writeback(mapping, index, end);
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 322ed268f14a..63b75d214210 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1045,11 +1045,7 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
>   	ceph_wbc->index = ceph_wbc->start_index;
>   	ceph_wbc->end = -1;
>   
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
> -		ceph_wbc->tag = PAGECACHE_TAG_TOWRITE;
> -	} else {
> -		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
> -	}
> +	ceph_wbc->tag = wbc_to_tag(wbc);
>   
>   	ceph_wbc->op_idx = -1;
>   	ceph_wbc->num_ops = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..196eba7fa39c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2619,10 +2619,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>   	handle_t *handle = NULL;
>   	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
>   
> -	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(mpd->wbc);
>   
>   	mpd->map.m_len = 0;
>   	mpd->next_pos = mpd->start_pos;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddfca3..101e962845db 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3003,10 +3003,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>   			range_whole = 1;
>   	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   retry:
>   	retry = 0;
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 47d74afd63ac..12394fc5dd29 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -311,10 +311,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
>   			range_whole = 1;
>   		cycled = 1; /* ignore range_cyclic tests */
>   	}
> -	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> -		tag = PAGECACHE_TAG_TOWRITE;
> -	else
> -		tag = PAGECACHE_TAG_DIRTY;
> +	tag = wbc_to_tag(wbc);
>   
>   retry:
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index a2848d731a46..884811596e10 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -370,6 +370,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
>   void writeback_set_ratelimit(void);
>   void tag_pages_for_writeback(struct address_space *mapping,
>   			     pgoff_t start, pgoff_t end);
> +xa_mark_t wbc_to_tag(struct writeback_control *wbc);
>   
>   bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
>   bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3e248d1c3969..243808e19445 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2434,7 +2434,7 @@ static bool folio_prepare_writeback(struct address_space *mapping,
>   	return true;
>   }
>   
> -static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
> +xa_mark_t wbc_to_tag(struct writeback_control *wbc)

The function is small enough, why not export it as an inline function?

The current version also lacks EXPORT_SYMBOL(), it may cause problems 
for fses built as a module.

Thanks,
Qu

>   {
>   	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
>   		return PAGECACHE_TAG_TOWRITE;


