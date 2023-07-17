Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B52756EF2
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGQV3E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 17:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQV3D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 17:29:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4A123
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jul 2023 14:29:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7680e39103bso253265685a.3
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jul 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689629341; x=1692221341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ9GqrpUvGJ18GqKg+0EExH8WlVqg7XUnpew4D3JhEM=;
        b=WddEDr3tgDXl42UgfDB7Nvh5AWh3en7KeWMXcBshRKv4a3/3rBQ12+plsiIpuP8Sw/
         JwHivlTlSEv8/GsshEoNiWm0DjkEgO2X96569ICos8pFiPukvVLxCuo7pSMa170RAImi
         mMSelpnLfYGsWF+nFW5gsoD9SSiwEINpjjnXZmCcVGsbaB9lKtHN10qL9z+mAiTUIsTq
         03mdVshqS+dZcv9QqO0mPb+1MIudk02tEsenHRFb1C5Qaefm8CZlUEifHaGqjFBhFeuL
         2x+5lqDGAqKAuDTnEnBlzBxfal7PsA7rmu3tz/LYqr1LFkE9KRKrwlf1LAzyCTh8FZhT
         ktTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689629341; x=1692221341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ9GqrpUvGJ18GqKg+0EExH8WlVqg7XUnpew4D3JhEM=;
        b=dyymo01UQe/Xpsm9I7H08T5lzWtp+8m69lcRJYJB1d2zo1T4mSAbYyzSnZj8sqSBfx
         0Cs2iwu+zpAHw84d3NM7wLtgtU24UP2oU58+tSUIDwbKUHH0Tc1e4+r7xcexCSxmnwJf
         OCnBJsYQ/DzC/xIM8Szfr/NfSE2I/L9jcph8tFBnudvIrkmmRsY2mf3QPK/HPKuuwmc6
         vKm/BlgJ2N/LOHGrKQndKoP53HWwJyz+EPnTiI6NZpsAzUffT4/RfOE075ij+kqSySVt
         v7E5XzbJGswqrGaYSO288o+vBqIFng1aeqwyEoSPjYcTK6kYJsLo9lXUAo2SqebKLbHg
         fmaA==
X-Gm-Message-State: ABy/qLZJvpatWK3bBUdtoUaRO5oIrzFSaxpuiXfN1lAxeNvRzcYfmqRc
        AIau8D+nVsWbyHo/4tK5rT6pARPmJhw=
X-Google-Smtp-Source: APBJJlFToHumsMSTy45UyT8cC7R3FhYkKZxpSYP/djuYltGoc0v8peQRTxgGhz10D+wsXfKGvC7fEA==
X-Received: by 2002:ae9:df44:0:b0:767:dd27:f91f with SMTP id t65-20020ae9df44000000b00767dd27f91fmr12176468qkf.4.1689629341649;
        Mon, 17 Jul 2023 14:29:01 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id k6-20020ae9f106000000b007592f2016f4sm69804qkg.110.2023.07.17.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:29:01 -0700 (PDT)
Date:   Mon, 17 Jul 2023 17:28:59 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: Don't use CR_BEST_AVAIL_LEN for non-regular files
Message-ID: <ZLWym4n0Z/Ucajbr@debian-BULLSEYE-live-builder-AMD64>
References: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a694c748ff8b8c4b416995a24f06f07b55047a8.1689516047.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ritesh Harjani (IBM) <ritesh.list@gmail.com>:
> Using CR_BEST_AVAIL_LEN only make sense for regular files, as for
> non-regular files we never normalize the allocation request length i.e.
> goal len is same as original length (ac_g_ex.fe_len == ac_o_ex.fe_len).
> 
> Hence there is no scope of trimming the goal length to make it
> satisfy original request len. Thus this patch avoids using
> CR_BEST_AVAIL_LEN criteria for non-regular files request.
> 
> Fixes: 33122aa930f1 ("ext4: Add allocation criteria 1.5 (CR1_5)")
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/mballoc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 3ab37533349f..bc004f5d3f3c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -975,7 +975,18 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
>  		*group = grp->bb_group;
>  		ac->ac_flags |= EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED;
>  	} else {
> -		*new_cr = CR_BEST_AVAIL_LEN;
> +		/*
> +		 * CR_BEST_AVAIL_LEN works based on the concept that we have
> +		 * a larger normalized goal len request which can be trimmed to
> +		 * a smaller goal len such that it can still satisfy original
> +		 * request len. However, allocation request for non-regular
> +		 * files never gets normalized.
> +		 * See function ext4_mb_normalize_request() (EXT4_MB_HINT_DATA).
> +		 */
> +		if (ac->ac_flags & EXT4_MB_HINT_DATA)
> +			*new_cr = CR_BEST_AVAIL_LEN;
> +		else
> +			*new_cr = CR_GOAL_LEN_SLOW;
>  	}
>  }
> 
> --
> 2.40.1
>

Works for me on 6.5-rc2 with this patch applied - 500/500 generic/269 trials
passed on bigalloc_1k.

Tested-by: Eric Whitney <enwlinux@gmail.com>

Thanks!
Eric
