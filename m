Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A41537663
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiE3IG3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiE3IG2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 04:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 811D475228
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653897985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FANm1doqZnuvQp8dqoXUwCaygSCiGRLAv8O5pwgkd1I=;
        b=FT3lr3xoE6dnVJ+dLv3lWgb68E1qUjHWooUW6VCwTTWG2U9HQPbTCiTRQTbi5TVtcq2eId
        yJUJrZqOuJ8tKEPv7Y9f75GoYTQ78m7Z5RDtgd8fpz7ghjAtq+B6sT+JekfDYc2gAo2HWD
        y4YB4gfUctlQqt85MlRcWHC+15AUj2U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-boJfrSKvMwCvFn5TqtVSJg-1; Mon, 30 May 2022 04:06:23 -0400
X-MC-Unique: boJfrSKvMwCvFn5TqtVSJg-1
Received: by mail-qk1-f198.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so5596035qkb.16
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 01:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FANm1doqZnuvQp8dqoXUwCaygSCiGRLAv8O5pwgkd1I=;
        b=RCPyf+abhjQcGz0C0rdCx4IL2rGWKXM8AEEb/tx4GgSO5/8ylxJy8QPFjpkQsWag4s
         vGSDsx0EfxO+KOU6JXTRhgTbOOFwrv52Q5TMRbKmucaJcp+enYj44PTitqHuBNQARvbU
         SwGUdhSQhyc/PIB/JCx4URm9kHgvvJtZmeXApBBvQtq+aSd5hiYli3Z/iyCGU3jWiwsR
         1JA0hB0k5gZZ+IYarT9lVunPRiLNKIwLQq2SfnsUi8vpyXpqWSD9s2o0qcR7u/6MfL6+
         LynIKpweI7lJxoFiT/SZu2VHkiiyaA50d7j9MG368yZ3Yrj6OO5XqebhA/eRrdEpD1+t
         zxNg==
X-Gm-Message-State: AOAM533pcE5FnNXeIINlMntRvepBejpYTDjHA/sEohN17AgCSaj4e5eU
        i6GV8/xAob3lzYNW3wav0c1pyVn9dc1f60E3diTZvI0EEm8k8xVGPVn8NoQnwj8/OOlXsAwggF/
        pY8HEY7U3I/jyYYbrJOQppw==
X-Received: by 2002:a05:620a:1999:b0:6a3:9689:a673 with SMTP id bm25-20020a05620a199900b006a39689a673mr25290035qkb.209.1653897983114;
        Mon, 30 May 2022 01:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwtUPQf7QR5FM8wxuF5OVRrZVbK4JcSC+4x2oKkmbJnqwcopcmaJy1biTf/RjE44gViBJnag==
X-Received: by 2002:a05:620a:1999:b0:6a3:9689:a673 with SMTP id bm25-20020a05620a199900b006a39689a673mr25290026qkb.209.1653897982871;
        Mon, 30 May 2022 01:06:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 2-20020a370802000000b0069fc13ce204sm7173565qki.53.2022.05.30.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:06:22 -0700 (PDT)
Date:   Mon, 30 May 2022 16:06:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Potential regression on kernel 5.19-rc0: kernel BUG at
 mm/page_table_check.c:51!
Message-ID: <20220530080616.6h77ppymilyvjqus@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi mm folks:

I reported a regression bug on latest upstream linux:
https://bugzilla.kernel.org/show_bug.cgi?id=216047

It's about xfs/ext4 + DAX, panic at mm/page_table_check.c:51!

  static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
  {
==>     BUG_ON(!page_ext);
        return (void *)(page_ext) + page_table_check_ops.offset;
  }

It's 100% reproducible for me, by running fstests generic/623:
  https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/623
on xfs or ext4 with DAX enabled.

It doesn't look like a xfs or ext4 issue, so send to linux-mm to get more
reviewing. More details please refer to above bug link. I changed its Pruduct
to mm, but the Assignee isn't changed by default.

Thanks,
Zorro

