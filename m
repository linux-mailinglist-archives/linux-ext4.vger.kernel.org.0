Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1663F198
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLAN2n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 08:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLAN2k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 08:28:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2FA6B5C
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 05:28:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so2014285pjd.5
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3zb9bzbc1nudqFX56hBeQYcU7kPog8itR+Xh0HoEjM=;
        b=AGqny4mS5DB+Z/7dWW2cAdUW/EdqxI+tl+JJGkedV8Qdm+NqFG+1tmByi7nzQcWbII
         0AE1BJwkAF5ghbxSrJq3M1qXAX2eoWA7hrXktWZrJyb8ol7WdA8In1QVIMCNwt8m15Md
         eAsGFv4rqIOkNck8UkXPOxiqTg0ME2ftYsSkewpdJ692Wc+GILObODjztfRLTwk+Cegd
         y0J7GQ235DbnnzhB8y0VTUG107CqWw03urq+UQL3Zdx9aN2IaWWpxmlAJo20clG+YaK/
         Qz4TSd6Zdn3DpxHQFIxBGW/rYHIh8unspMF8WdQFtILwb5YGTchkSdN+eNRDv6tPHuZi
         MKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3zb9bzbc1nudqFX56hBeQYcU7kPog8itR+Xh0HoEjM=;
        b=Nmptx6IiYT0QIV6vTy8LoV5kKeT3bKI6sg5LfitV2g0VwytTLVgVTXu9pgbTGyuOje
         97Y/Yv/kjTUeWa76rMjIDaZac6V/UimFJa81dXA/HmdVfcjn/9aKSAtzZmvHcfNqpwtL
         yGU2u8i+ohu19579RbgoJNGlnUmPiFV6b4rpBXhhRQGb8EFgqwas+dMuWIYxitfe+28B
         bL5RQ68tjDrzmEY37tHfpz3nofYgeagBe9SV8H57AH0/Gv+BfspQteHyFS/RX8vJpaMk
         L3VwWQup29acMPFjPwIzCNryN2UFmiGn+mkczKLzmJ8vsGD/kSA6SOVRU3ON/ANY4suM
         ueEQ==
X-Gm-Message-State: ANoB5pkdn4tV7rQmEANarskOUhu2TK+shukDEVkqXO72t6ymropARa/P
        vhuD5CGghW5dn++jdHe04Y39STzXrLE=
X-Google-Smtp-Source: AA0mqf755PQfMIoZm8HyPYaRzpKlSzJbfrInEacbIy/NsJyqETyhTWYG8BawfMRfKHunIvv0YmhmYg==
X-Received: by 2002:a17:902:e949:b0:189:7a15:1336 with SMTP id b9-20020a170902e94900b001897a151336mr25891883pll.122.1669901314610;
        Thu, 01 Dec 2022 05:28:34 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm3241261pfc.34.2022.12.01.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:28:34 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:58:28 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/9] ext4: Add support for writepages calls that cannot
 map blocks
Message-ID: <20221201132828.3ymp4e25myo2hmdm@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-5-jack@suse.cz>
 <20221201111359.onr5edsaaxcr2ndh@riteshh-domain>
 <20221201115019.jot525ry25gk4ggh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201115019.jot525ry25gk4ggh@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/01 12:50PM, Jan Kara wrote:
> > > +			/*
> > > +			 * Writeout for transaction commit where we cannot
> > > +			 * modify metadata is simple. Just submit the page.
> > > +			 */
> > > +			if (!mpd->can_map) {
> > > +				if (ext4_page_nomap_can_writeout(page)) {
> > > +					err = mpage_submit_page(mpd, page);
> > > +					if (err < 0)
> > > +						goto out;
> > > +				} else {
> > > +					unlock_page(page);
> > > +					mpd->first_page++;
> >
> > We anyway should always have mpd->map.m_len = 0.
> > That means, we always set mpd->first_page = page->index above.
> > So this might not be useful. But I guess for consistency of the code,
> > or to avoid any future bugs, this isn't harmful to keep.
>
> Yes, it is mostly for consistency but it is also needed so that once we
> exit the loop, mpage_release_unused_pages() starts working from a correct
> page.

Oh yes! right.

-ritesh

