Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198F6C122B
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCTMp0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjCTMpO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 08:45:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43F5C67C;
        Mon, 20 Mar 2023 05:44:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B43F1F86C;
        Mon, 20 Mar 2023 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679316285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csb4A/GteL7sk6OWuZo8wtDFvG6wLJAej3F6d9wonWM=;
        b=BF/wbRGhwSoWqJjgX/ILwVnn1R/mNxSiPXfU8njNErZvQns2PrdZvgXVBOmT/BGHTqBaV/
        yLN5fHWc9uykN18/5p2CAcTTHeqTBB4IHtmWBHfMGVQwW/NCZZ4/zsa13k5nlP0Z9OdpLp
        ZluulV6ziGnelgY5Q0PtQ1khAjVddrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679316285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csb4A/GteL7sk6OWuZo8wtDFvG6wLJAej3F6d9wonWM=;
        b=93OYhAZFDIDPEt4KKwCA1czSGoIpnWvo7DsK8xXn/X8UD4kx/eSF7YyO21V7yRvlxzBatL
        ec6DDmaQYe2JwyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4885113A00;
        Mon, 20 Mar 2023 12:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HbSzET1VGGRNZQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 12:44:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AD839A0719; Mon, 20 Mar 2023 13:44:44 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:44:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ext4: improve inode table blocks counting in
 ext4_num_overhead_clusters
Message-ID: <20230320124444.kkp4es2wyke7vqgx@quack3>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
 <20230221115919.1918161-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221115919.1918161-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-02-23 19:59:19, Kemeng Shi wrote:
> As inode table blocks are contiguous, inode table blocks inside the
> block_group can be represented as range [itbl_cluster_start,
> itbl_cluster_last]. Then we can simply account inode table cluters and
> check cluster overlap with [itbl_cluster_start, itbl_cluster_last] instead
> of traverse each block of inode table.
> By the way, this patch fixes code style problem of comment for
> ext4_num_overhead_clusters.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

FWIW this is triggering Coverity warning:

*** CID 1536792:  Uninitialized variables  (UNINIT)
/fs/ext4/balloc.c: 153 in ext4_num_overhead_clusters()
147                     inode_cluster = EXT4_B2C(sbi,
148                                              ext4_inode_bitmap(sb, gdp) - st
149                     /*
150                      * Additional check if inode bitmap is in just accounted
151                      * block_cluster
152                      */
>>>     CID 1536792:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "block_cluster".
153                     if (inode_cluster != block_cluster &&
154                         inode_cluster >= base_clusters &&
155                         (inode_cluster < itbl_cluster_start ||
156                         inode_cluster > itbl_cluster_end))
157                             num_clusters++;
158             }

which actually looks valid AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
