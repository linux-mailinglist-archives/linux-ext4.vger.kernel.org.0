Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4186C6C0A06
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 06:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCTFXp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCTFXn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 01:23:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D56D11661
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 22:23:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r16so11843172qtx.9
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679289819;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAg/di4awCbENQSDHCw3uwPaVCnYn/JqQu0b5lYNlhA=;
        b=p9Y2XtE4tcxGUhH+2fluWD0s4npx8Ylcmiofp0dtrqwoGanjdCTVnqg/qMO9B2Eqee
         kJXhUMep3Gz11MElDyCICekSrou5OCXn0KcsjLzta/7S4NXBQ0kAPCCVyubft88a3Elh
         nqu9KKJuvvc4mgDntldKav+//BdLjpY+W1y9F+/oC6RLQag0ajP/d8mSihCI0LQHTscN
         iw4DDucZAA8uSQduK5FuwKdRjql9QLvxP/TP1GhC2AgZJo7kkKfwT7aIEbKJ45sCYU3I
         WQfFiYo6WhPxnQFuL1eZb84t4CXllzGE4KX05JrDvIh2ChxlBcEN4ACNkRgNjlZBwVgk
         gQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679289819;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAg/di4awCbENQSDHCw3uwPaVCnYn/JqQu0b5lYNlhA=;
        b=TrGfikhkD+un5VwEyfKFSOUOL8s828nwoHJ5NhYe/wgnP/yuRspb2gFJ2D81yoQKn5
         F6Q21CNkz8O/If7i+b0VAEOqKVus84QtUh+Q/MlEhmvq5ciE0ujwq3aLkWzA/kjRKvjb
         punObJNoxcdKHDYsoRMnwemJp9P424jhj3HFf6I5Tetu+oIkUpZ+9vazzVg+eICqqlQ1
         pfgPxWmsQQkvVUowRU+OP5k0JFkxJagiVP/ntZovy7CquUqAbh2u7BFyeNHzc/JBW/dH
         xyfHiyccB5ZADI/773ze/wiK4OU1xPiCWUciSNUbKPsAxqDYGMLMZQDWjO0itj1FR7xL
         unGQ==
X-Gm-Message-State: AO0yUKWX3dHLKlzHvI87Ix93QtJ/zelgXApRNt6oMW+f7w9Nt076eHL8
        fuQz9HZ9OmQ6DxvNi5TsplBviw==
X-Google-Smtp-Source: AK7set+IHAVwOVPGzgDiA1M/gc/Y2e4sY27FJ8NVOQKNJGtuM2ssre+J8mfq1AKrGS8jlMrrQZHYtw==
X-Received: by 2002:ac8:7dc2:0:b0:3b8:4076:1de0 with SMTP id c2-20020ac87dc2000000b003b840761de0mr25174802qte.30.1679289819622;
        Sun, 19 Mar 2023 22:23:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r19-20020ac85213000000b003b643951117sm6038919qtn.38.2023.03.19.22.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 22:23:39 -0700 (PDT)
Date:   Sun, 19 Mar 2023 22:23:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christoph Hellwig <hch@lst.de>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 5/7] shmem: open code the page cache lookup in
 shmem_get_folio_gfp
In-Reply-To: <20230307143410.28031-6-hch@lst.de>
Message-ID: <af178ebb-1076-a38c-1dc1-2a37ccce4a3@google.com>
References: <20230307143410.28031-1-hch@lst.de> <20230307143410.28031-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 7 Mar 2023, Christoph Hellwig wrote:

> Use the very low level filemap_get_entry helper to look up the
> entry in the xarray, and then:
> 
>  - don't bother locking the folio if only doing a userfault notification
>  - open code locking the page and checking for truncation in a related
>    code block
> 
> This will allow to eventually remove the FGP_ENTRY flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Hugh Dickins <hughd@google.com>

but Andrew, please fold in this small improvement to its comment:

[PATCH] shmem: open code the page cache lookup in shmem_get_folio_gfp fix

Adjust the new comment line: shmem folio may have been swapped out.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1905,7 +1905,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	if (folio) {
 		folio_lock(folio);
 
-		/* Has the page been truncated? */
+		/* Has the folio been truncated or swapped out? */
 		if (unlikely(folio->mapping != mapping)) {
 			folio_unlock(folio);
 			folio_put(folio);
