Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC88549E23
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jun 2022 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbiFMTyB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jun 2022 15:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiFMTxx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jun 2022 15:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D43E9A9B6
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jun 2022 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655144683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yY0MNFDhB0MuSHpTInllqJNSaIJfsG15wflCu/cwAgA=;
        b=RFpZCKEeNBMIBAlMiVycXYzLLeVelvCC/0ZYTiwi7dn1YBUN0he/Hc89JkLAf0r68wbCOl
        n/5WvhWu9WQ+kqCLafGKHJCS4uAj1puCIHpg/bfXYvOHRCNJXUL7DKVY4bCcgfopx+rV7p
        7/mJB2wz/t5RDbXVladhCAwkLQ4uGWg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-fVoiLmMGMOuP8s9UZNBDIA-1; Mon, 13 Jun 2022 14:24:39 -0400
X-MC-Unique: fVoiLmMGMOuP8s9UZNBDIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40B5C3801144;
        Mon, 13 Jun 2022 18:24:39 +0000 (UTC)
Received: from fedora (unknown [10.40.193.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9182E1415103;
        Mon, 13 Jun 2022 18:24:38 +0000 (UTC)
Date:   Mon, 13 Jun 2022 20:24:36 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] ext4: Debug message and export cleanups
Message-ID: <20220613182436.4cnyobjwkprhcxh2@fedora>
References: <20220608112041.29097-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608112041.29097-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 08, 2022 at 01:23:46PM +0200, Jan Kara wrote:
> Hello,
> 
> this series cleans up couple of things around debug messages in ext4/jbd2
> and removes some unnecessary exports.
> 
> 								Honza

The series looks good to me.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

-Lukas

