Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C186C6F8EC5
	for <lists+linux-ext4@lfdr.de>; Sat,  6 May 2023 07:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEFFvz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 01:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEFFvy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 01:51:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FAB4C1A;
        Fri,  5 May 2023 22:51:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 135CB5C00BC;
        Sat,  6 May 2023 01:51:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 06 May 2023 01:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683352310; x=1683438710; bh=NF
        ynHyiGKZDQAJtL0CirqWpcs9b5k8E5/94VkrnAK0Y=; b=TxHbFunhGnMOZFmzpU
        NI84NUJG+kOjg7yvn/y/lI5HNE7nnaFGuUCJEDbHoeqN3pWciIjsmgP6uYUn/5rj
        ehzwbGwgd96B+DIzZuVO2eiR/fNsVfLH3EGEa3eZaNA78SVLVKGt5wAwNlHhPpHt
        IAmkmXb48eXaOttVLYnZmF8i4oZJuT75/Gdf5X++2nS212m0LOO779hdZqBlq01Y
        lypyxlsV1Ff8C6mzMeJGWUV3qqqUhSYo0ZwZSfY/IohDeJx9Go6lUulJB1qP8Rwn
        3Cxrt9NjNDsBd+vmWCfoEDCprfhWPKjtZV8xN5ccTum4MmQhtaw+pJlx9/qUALfn
        Jamg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683352310; x=1683438710; bh=NFynHyiGKZDQA
        JtL0CirqWpcs9b5k8E5/94VkrnAK0Y=; b=gjApKP1B6PISDjnXXQ5WCHKSvLban
        +W5LbG1tpZqQbq78JJldOBq0cknhOglB+hm1jjg63QFVRWe+WdskGxOyeEH6S2UG
        cg80USiIpigwI40hAPHbIKzAzziAhfhDuNlxiHE3/+kCArDWt+lG/CJRifNdhlSp
        3hzLI7guegbsmajOldcRkjUwKe5jxv3spIyDyruY8RxrnRuFCictDC/DvsGebLjh
        yaS4FmU8utC01B5/a/rHSUJIvFAub2zSFnJu3RRBj/vt+iNRq0zT9PTCYrVyaH1j
        XVh5q3GUSVt1uOgpcLDzHo6MDq0YzaiIJ7ufxys4W2DbcVIxd3b+zKQhw==
X-ME-Sender: <xms:9epVZNGhyRvNvSLzD1YGW32eB2CVXxOGC9HJmCUtYnByVj4DGqi7JA>
    <xme:9epVZCXI3a5O1ZSSuNfMpH1PFBvSXzjYe7NZKsjQfj_luBDhpiht2YLJUKdOgOXaD
    S7kpwdVw2aHRQ>
X-ME-Received: <xmr:9epVZPLNu0XlIwejzkHVZnRA8b4YqoizF-yTNdX66UD2YcRrK469mJXq-Ik1RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtgho
    mheqnecuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejke
    ejuefhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:9epVZDGI-WfJZ_0djySNO1gpih0fuHz9fPlc25KELsk56q_dkXm_Ew>
    <xmx:9epVZDXHCr0vLH4Xy7objqRLr5fCO3-LsyriJ0fxBs-bhcvTB-hfoA>
    <xmx:9epVZOMLU0j3lJC7bu6h_kVnqhrjJF7BWRXJ2-XnKdn79Xs_Prhklg>
    <xmx:9upVZA16M2MzOwTTNM79_8ZrKEdlsN5Z_IkRKLaf0FOFwHTyLK9-LQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 01:51:48 -0400 (EDT)
Date:   Sat, 6 May 2023 09:58:41 +0900
From:   Greg KH <greg@kroah.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     stable@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, tangyeechou@gmail.com
Subject: Re: [PATCH 0/1][For stable 5.4] mm: migrate:
 buffer_migrate_page_norefs() fallback migrate not uptodate pages
Message-ID: <2023050612-thee-chafe-569c@gregkh>
References: <20230503163426.5538-1-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503163426.5538-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 04, 2023 at 12:34:25AM +0800, Yue Zhao wrote:
> Recently we found a bug related with ext4 buffer head is fixed by
> commit 0b73284c564d("ext4: ext4_read_bh_lock() should submit IO if the
> buffer isn't uptodate")[1].
> 
> This bug is fixed on some kernel long term versions, such as 5.10 and 5.15.
> However, on 5.4 stable version, we can still easily reproduce this bug by
> adding some delay after buffer_migrate_lock_buffers() in __buffer_migrate_page()
> and do fsstress on the ext4 filesystem. We can get some errors in dmesg like:
> 
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
>   comm fsstress: reading directory lblock 0
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
>   comm fsstress: reading directory lblock 0
> 
> About how to fix this bug in 5.4 version, currently I have three ideas.
> But I don't know which one is better or is there any other feasible way to
> fix this bug elegantly based on the 5.4 stable branch?
> 
> The first idea comes from this thread[2]. In __buffer_migrate_page(),
> we can let it fallback to migrate_page that are not uptodate like 
> fallback_migrate_page(), those pages that has buffers may probably do
> read operation soon. From [3], we can see this solution is not good enough
> because there are other places that lock the buffer without doing IO.
> I think this solution can be a candidate option to fix if we do not want to
> change a lot. Also based on my test results, the ext4 filesystem remains
> stable after one week stress test with this patch applied.
> 
> The second idea is backport a series of commits from upstream, such as
> 
>   2d069c0889ef ("ext4: use common helpers in all places reading metadata buffers")
>   0b73284c564d ("ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate")
>   79f597842069 ("fs/buffer: remove ll_rw_block() helper")

Backporting the original upstream commits is almost always the correct
solution.  Please try doing that instead of a one-off patch like this.

thanks,

greg k-h
