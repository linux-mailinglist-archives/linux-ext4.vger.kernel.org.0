Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5E6E0B74
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDMKe6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Apr 2023 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjDMKe4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Apr 2023 06:34:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0930FB;
        Thu, 13 Apr 2023 03:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90BC61F383;
        Thu, 13 Apr 2023 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681382088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRmU1UOn8b5dubK28JOLEnSxE8xtD2PQEvlIOjmwKlc=;
        b=YZhAicgBQ8IEqcLhF69qcmhxbTpTCqxT4IwvnVHg+An0NjGNp8IrFc5cewA0IyrOwZyjUw
        J9c/a+xjjxNzG7+bPEgNI2owhaf6s/RSf4Qbw9iYPUS/2rgAUIzIvAtc/8zZ8GrWFbD+ni
        DjXL2M8Eriw6mmibztYfUvkg6gQSXw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681382088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRmU1UOn8b5dubK28JOLEnSxE8xtD2PQEvlIOjmwKlc=;
        b=bH+VKwUAk2J4eiCwYA36BbIXQ/qLuhvWxxHR68EjjNjXqtASau2YdBXqLPjMrbAljka3uq
        gbYGQuNNJVbkGIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 817731390E;
        Thu, 13 Apr 2023 10:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 582RH8jaN2SnTgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 13 Apr 2023 10:34:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 04640A0732; Thu, 13 Apr 2023 12:34:47 +0200 (CEST)
Date:   Thu, 13 Apr 2023 12:34:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 2/8] ext4: add a new helper to check if es must be kept
Message-ID: <20230413103447.br5wgi6zhaaarcaz@quack3>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-3-libaokun1@huawei.com>
 <20230412185300.rpfwdlxeiptqaxes@quack3>
 <22b3bfef-7a47-036d-125b-180040a0c743@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b3bfef-7a47-036d-125b-180040a0c743@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 13-04-23 10:00:56, Baokun Li wrote:
> Can you please help review the remaining patches for any problems?
> If you have any suggestions, I'll fix them together and post another version
> of v4.

Yes, I've got a bit stuck thinking about the GFP_NOFAIL problem and how to
best solve it. It will require some changes but most of the patchset can
stay I believe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
