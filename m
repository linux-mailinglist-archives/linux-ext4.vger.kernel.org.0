Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63292380E10
	for <lists+linux-ext4@lfdr.de>; Fri, 14 May 2021 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhENQU6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 May 2021 12:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhENQU6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 May 2021 12:20:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DBC061574
        for <linux-ext4@vger.kernel.org>; Fri, 14 May 2021 09:19:46 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 76so29198694qkn.13
        for <linux-ext4@vger.kernel.org>; Fri, 14 May 2021 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wYRsRR0wHJ1X/+cx8GBGw0BY216vlgIyfjpfE+AP+w8=;
        b=jK/VKuyfomuJF8DY/xVryTIITBw7y0a7J+kDlN2VpL/cXX4szYj7k2CDhC/1DkG2b+
         EqX3nzYDJ4c/Y21D/rqU91Y209IW3pwchzeyaQHSObEPIBj/rKTCFu/5Ycxi54mtHxQK
         G/7Wytl+Bano8gW5wZjcqGsqFzNB3ATa0Lv08b6ocaeD3Tc21ORwsJgkOHiDmNI6iv5t
         bzu4ANErF1bEoaeXlEH70R7oCh/6FVyFOrZ8Wm8vrWbbeVW/ViMn/3dmvWC6IttlNMQm
         j04BWwh9wz6A5CfJUrsmYpgBX9ZWIDohc7dwNRvErbeREGPcxM3gTIN1Sjy1t8/xLznn
         HIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wYRsRR0wHJ1X/+cx8GBGw0BY216vlgIyfjpfE+AP+w8=;
        b=X5cHFViWIWdu+phDm7SLNr4EPWpfYqkubz+rDNdNhei+ZbFgAbbpxiD7Mdl01qJdcU
         U9ytxycwvVMT/GEkVzBFDSYUfx52cvgHKjbw+8Ae/H79pFWbVRPc0rLoRv1rsF2beZy/
         mLq8Lw1JZTakzm2km7RU+OuoB6O2qEDJkaUG3+ppgYYI6gwgJz3ucdjCOzHmQUKzMokd
         gh/N6lUsPgjntPqYWOP/nAxHlop4i44WDXJvma7gjgGTAh8CT1z4FlImW5+5OgO85S5m
         /b2CFKLdd07Z13+ibZu3mdKxODesIDoOoF0idxtaAWqdRqFTGjXsiogFv7noirjI7E+M
         uWzw==
X-Gm-Message-State: AOAM530THLIySkBRNGY7qyGJ43+yjbrj7SpVGB9x11IWL1am1w5sg49o
        TO5Mrpr5mXwOFsIodJDCbDgJQdRqFDa0Sw==
X-Google-Smtp-Source: ABdhPJwQR7vS34xfCA6lkkRZB8CojhJv8D4nfncK04uDGO0+qv8H3cLXalbUcjh59Wiodh+w0p7EKg==
X-Received: by 2002:a37:b4e:: with SMTP id 75mr45432187qkl.281.1621009185402;
        Fri, 14 May 2021 09:19:45 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:8626:664b:8242:8ae7])
        by smtp.gmail.com with ESMTPSA id j9sm5283397qtl.15.2021.05.14.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:19:45 -0700 (PDT)
Date:   Fri, 14 May 2021 12:19:43 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <YJ6jH3jVkYS5sBW5@google.com>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
 <YJ1rVr7Sf7Az+MQm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1rVr7Sf7Az+MQm@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 13, 2021 at 02:09:26PM -0400, Theodore Ts'o wrote:
> > +
> > +	err = jbd2_journal_bmap(journal, log_offset, &block_start);
> > +	if (err) {
> > +		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
> > +		return err;
> > +	}
> 
> We could get rid of this, and instead make sure block_start is initialized
> to ~((unsigned long long) 0).  Then in the loop we can do...
> 
> > +
> > +	/*
> > +	 * use block_start - 1 to meet check for contiguous with previous region:
> > +	 * phys_block == block_stop + 1
> > +	 */
> > +	block_stop = block_start - 1;
> > +
> > +	for (block = log_offset; block < journal->j_total_len; block++) {
> > +		err = jbd2_journal_bmap(journal, block, &phys_block);
> > +		if (err) {
> > +			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
> > +			return err;
> > +		}
> 
> 		if (block_start == ~((unsigned long long) 0)) {
> 			block_start = phys_block;
> 			block_Stop = block_start - 1;
> 		}
> 
> > +
> > +		if (block == journal->j_total_len - 1) {
> > +			block_stop = phys_block;
> > +		} else if (phys_block == block_stop + 1) {
> > +			block_stop++;
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * not contiguous with prior physical block or this is last
> > +		 * block of journal, take care of the region
> > +		 */
> > +		byte_start = block_start * journal->j_blocksize;
> > +		byte_stop = block_stop * journal->j_blocksize;
> > +		byte_count = (block_stop - block_start + 1) *
> > +				journal->j_blocksize;
> > +
> > +		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
> > +				byte_start, byte_stop);
> > +
> > +		if (flags & JBD2_ERASE_FLAG_DISCARD) {
> > +			err = blkdev_issue_discard(journal->j_dev,
> > +					byte_start >> SECTOR_SHIFT,
> > +					byte_count >> SECTOR_SHIFT,
> > +					GFP_NOFS, 0);
> > +		} else if (flags & JBD2_ERASE_FLAG_ZEROOUT) {
> > +			err = blkdev_issue_zeroout(journal->j_dev,
> > +					byte_start >> SECTOR_SHIFT,
> > +					byte_count >> SECTOR_SHIFT,
> > +					GFP_NOFS, 0);
> > +		}
> > +
> > +		if (unlikely(err != 0)) {
> > +			printk(KERN_ERR "JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
> > +					err, block_start, block_stop);
> > +			return err;
> > +		}
> > +
> > +		block_start = phys_block;
> > +		block_stop = phys_block;
> 
> Is this right?  When we initialized the loop, above, block_stop was
> set to block_start-1 (where block_start == phys_block).  So I think it
> might be more correct to replace the above two lines with:
> 
> 		block_start = ~((unsigned long long) 0);
> 
> ... and then let block_start and block_stop be initialized in a single
> place.  Do you agree?  Does this make sense to you?

I just tried this and it actually wouldn't work with this setup because
phys_block would be set after the new call to bmap instead of keeping the value
from the end of the prior loop. However, I have reworked the code using the
general idea of the block_start reset you proposed and I will submit this in
the next version.

Thanks,
Leah

> 
> 	       	       	    	      	    - Ted
