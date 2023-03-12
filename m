Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2593C6B64C9
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Mar 2023 11:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCLKQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Mar 2023 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCLKQG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Mar 2023 06:16:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E233445;
        Sun, 12 Mar 2023 03:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97A40B8074D;
        Sun, 12 Mar 2023 10:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EA6C433EF;
        Sun, 12 Mar 2023 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678616144;
        bh=0QoZ25WKO3KeHJjM6NGw13wdy4JSU0OnGMtI6QJDCJQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kiqI9HhI+w8bSxtDQI7ueuco+IZWwUXVsdcXz2Opm9qF9y0iGi2ioixxlDUTUP/7p
         11IJXROpXi+8n/yeG7gqCvwEE0gVv3mMJxXDbDojn/NASfpZdZbCo4arRYxFY/R7sc
         SzHWy5DW9bz4rSvbsCC4FHsElSc+5OQeUFBJln0iy6tVuI/18qFGK4OWnWWCbG039p
         74xRbqOfy2qN9yaM3ejP95f36faBpqOdrKYGJ3sxe4dHG56zFHUbCaU9mgLatSrt7B
         K9SRWVkW74VrgUhEx5Ey0+eulXIvIHLYmnutC+0jylsSuDACZ4XGSBMmv3X2v9+FQy
         IuwXGkAgf9QgA==
Message-ID: <265f6c37-fae7-6ab2-594f-e7785aedb4e6@kernel.org>
Date:   Sun, 12 Mar 2023 18:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
References: <20230308011807.411478-1-chao@kernel.org>
 <20230311031843.GF860405@mit.edu>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] ext4: fix to report fstrim.minlen back to userspace
In-Reply-To: <20230311031843.GF860405@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/11 11:18, Theodore Ts'o wrote:
> Unfortunately, this patch is not correct.  The units of struct
> fstrim_range's minlen (here, range->minlen) is bytes.

Oh, that's right, sorry for the mistake.

> 
> However the minlen variable in ext4_trim_fs is in units of *clusters*.
> And so it gets rounded up two places.  The first time is when it is
> converted into units of a cluster:
> 
> 	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
> 			      range->minlen >> sb->s_blocksize_bits);
IIUC, if range->minlen is smaller than block size of ext4, above calculation
may return a wrong value, due to it looks EXT4_NUM_B2C() expects a non-zero
in-parameter.

So it needs to round up minlen to block size first and then round up block
size to cluster size:

	minlen =  EXT4_NUM_B2C(EXT4_SB(sb),
		EXT4_BLOCK_ALIGN(range->minlen, sb->s_blocksize_bits));

Or do the conversion at a time as you reminded:

	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
		(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));

> 
> And the second time is when it is rounded up to the block device's
> discard granularity.
> 
> So after that if statement, we need to convert minlen from clusters to
> bytes, like so:
> 
> 	range->minlen = EXT4_C2B(EXT4_SB(sb), minlen) << sb->s_blocksize_bits);

Thanks for the detailed explanation and reminder. :)

Thanks,
