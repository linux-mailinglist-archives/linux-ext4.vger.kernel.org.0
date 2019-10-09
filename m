Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669ACD0E5F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 14:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfJIMI0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 08:08:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbfJIMI0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 08:08:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so1499914pfb.7
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1BWwoGjmwO49xL/8yuSea//sNNjGxnZWDCNi/EPKNE=;
        b=YmdITmbreviovSJyRzR+plEZVGUq/kjsdsI4WZN6Of6Np+kirXx36tzuphI05HKCwi
         UR9EJJFjvACIOUzCaR129hEWk+amPAYIz4BnS0rJcJ/RgitTslLYvPkNEHZAtrSYws61
         ks+OKjJo+/8/d4bR3O/iQLto4d1aYEaecFIwdTO6KVd21CupSpepBFei64nNTrdtOwwH
         +2zjRQkg2SmgBsst7POeWvY2Rxn+izWEeLqnb5KnxAHciemr0bEKTXlai55uiVJlLRpb
         TbaQsIpmmiLs8aqqmC4ROTwwNO3gxGveNZZtoQ0/AYe6WKRqTF1JRQ2Uxeph8g8HXwTS
         SIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1BWwoGjmwO49xL/8yuSea//sNNjGxnZWDCNi/EPKNE=;
        b=JHqdJYCEMniAOsH61QDt1TEAvi1+NrVISk4eb4qfr2QD4qUK9HWicFSBJESjZEiq1V
         zLgN0xR6X1xxOdssxQWb7tcIi4RuEK43Jb0OTpGKotNQkEhVdQpbCQ1MoRb6uiVKU5rx
         CZppCfxeCmg8ofJO7LcpXICIK2BvzSfhl82SwcCJfj8B9vwrtwAKUFEseYiIyFvB23Iq
         Il9QX1VpsGb7Qx/cLkzpQ/CN9uWeF3CcJDJJYt8RaVS/D3rfKrWT4QcjogFaANESDSED
         0uiDpzoYyXQFbNudAlm00QM5Zp0YL7OixlPkyQDRO/PzeL0XkFpKu8U+4AFs0fPUyxxo
         e0Ng==
X-Gm-Message-State: APjAAAVgTXzRO+Ga8xZBPRSICmxM+2pDwKYcENsXDFbknFIVjkdYNYOm
        q5mZjFuwbcnvydHw080dVfgv
X-Google-Smtp-Source: APXvYqzuhuqQkShha9mtAmxxW8JgGsg3xjVouw9b/I1du0sMK1AdK/Fq4hfPqO2vPNEaMg23+tYsjA==
X-Received: by 2002:a63:c509:: with SMTP id f9mr3897327pgd.79.1570622905002;
        Wed, 09 Oct 2019 05:08:25 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id k124sm2122953pgc.6.2019.10.09.05.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 05:08:24 -0700 (PDT)
Date:   Wed, 9 Oct 2019 23:08:18 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
Message-ID: <20191009120816.GH14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 11:30:21AM +0530, Ritesh Harjani wrote:
> > +static u16 ext4_iomap_check_delalloc(struct inode *inode,
> > +				     struct ext4_map_blocks *map)
> > +{
> > +	struct extent_status es;
> > +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
> > +
> > +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
> > +				  end, &es);
> > +
> > +	/* Entire range is a hole */
> > +	if (!es.es_len || es.es_lblk > end)
> > +		return IOMAP_HOLE;
> > +	if (es.es_lblk <= map->m_lblk) {
> > +		ext4_lblk_t offset = 0;
> > +
> > +		if (es.es_lblk < map->m_lblk)
> > +			offset = map->m_lblk - es.es_lblk;
> > +		map->m_lblk = es.es_lblk + offset;
> This looks redundant no? map->m_lblk never changes actually.
> So this is not needed here.

Well, it depends if map->m_lblk == es.es_lblk + offset prior to the
assignment? If that's always true, then sure, it'd be redundant. But
honestly, I don't know what the downstream effect would be if this was
removed. I'd have to look at the code, perform some tests, and figure
it out.

> > +	map.m_lblk = first_block;
> > +	map.m_len = last_block = first_block + 1;
> > +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret == 0)
> > +		type = ext4_iomap_check_delalloc(inode, &map);
> > +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> We don't need to send first_block here. Since map->m_lblk
> is same as first_block.
> Also with Jan comment, we don't even need 'type' parameter.
> Then we should be able to rename the function
> ext4_set_iomap ==> ext4_map_to_iomap. This better reflects what it is
> doing. Thoughts?

Depends on what we conclude in 1/8. :)

I'm for removing 'first_block', but still not convinced removing
'type' is heading down the right track if I were to forward think a
little.

--<M>--

