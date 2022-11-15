Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B11628FF4
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Nov 2022 03:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKOCeo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Nov 2022 21:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKOCeo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Nov 2022 21:34:44 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AF14D06
        for <linux-ext4@vger.kernel.org>; Mon, 14 Nov 2022 18:34:43 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x16so6733292ilm.5
        for <linux-ext4@vger.kernel.org>; Mon, 14 Nov 2022 18:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5DBoIqNagH3XrdRY1r6Eco1A6aUzboNusmzdLRomUQ=;
        b=BhLHIICyakMONq9rF7PTSR31xmu60lcMvmCY2Ved5pkA3CMCOwasit37iZcXH0t3gO
         vrFIOD/CM1U2YYMLP1XsvBhAbnHH4PJKe3YQ0MjuyKctAqaf9Ff7fMqBk+SsV2m8+3db
         71ZCvALpPlT/q2S+hSblu9+dC/IKszNgG+3jzwGoUOG9Zy2wWDRYNPJpeWnK8/HcE24t
         3JiAgikkYgpvRkYFtTiB+4T5XYg65wOvoTqt7zqXOOM5yuEy0AX0TtI/ZtUUXicF99Ss
         HsFcjTd41n/aJfhMi1UN+8CIJuQtL0jJjhlOHwj22oV7V2hF2B46FKI4hNuo8rvD+or6
         FEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5DBoIqNagH3XrdRY1r6Eco1A6aUzboNusmzdLRomUQ=;
        b=U/nZqI+cdGRYRJy6FhxGeaGZBILvEAoz8N+7ks0MOvLz3zAaC+95crx1fCFMkccaEs
         HWqNicd9CnSLGH4hgJu8OH5tdB/Wl0LuEfvbFHGu8TnZSJ4HNbll3UPPpaKCCwpsUuEl
         gIMenSvZYrYSRvsqgLLL/D7n0pRNnfCDTCZqfLMnfmogr3T5PFa10dh4gFMKTHMJ7JUb
         jYejcH5Msn1RdJJdY/VduJFTwxNLHUU00Y06C+IneRUrXyOX+bS0wKOV/unx4aAbl2Cw
         wUE+b605ndOwUXGJ0B/fFAD8DCrO9LkgH7fHKCWb9ONGaNyZU5w1dszWncLjA0gOYlui
         NcDA==
X-Gm-Message-State: ANoB5pk23953s823Y1O+41SzpGQUrsumwRKXsbV2TXt2q5ZhMmLR/aku
        8WTLBP4R6bd39S94U16lLrxQOw==
X-Google-Smtp-Source: AA0mqf7kAKIWh2OS1WpDznT7RyX7mgjfWyyk2UEacMxAMSsL23+bcKLTzBzFPbqhHAEvBf20J60FbQ==
X-Received: by 2002:a92:d305:0:b0:2f9:b594:970 with SMTP id x5-20020a92d305000000b002f9b5940970mr7467585ila.56.1668479682530;
        Mon, 14 Nov 2022 18:34:42 -0800 (PST)
Received: from elrond.bobcopeland.com ([142.113.148.203])
        by smtp.gmail.com with ESMTPSA id e99-20020a02866c000000b0035b3e0a3243sm4064564jai.57.2022.11.14.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:34:42 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 0953CFC00A9; Mon, 14 Nov 2022 21:34:37 -0500 (EST)
Date:   Mon, 14 Nov 2022 21:34:37 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 8/9] omfs: remove ->writepage
Message-ID: <Y3L6vah7mSxFjZ28@bobcopeland.com>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-9-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 13, 2022 at 05:29:01PM +0100, Christoph Hellwig wrote:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
> 
> Set ->migrate_folio to the generic buffer_head based helper, and remove
> the ->writepage implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
