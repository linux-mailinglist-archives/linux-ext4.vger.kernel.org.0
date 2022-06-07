Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09FB53FEAB
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 14:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbiFGMXQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbiFGMW5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 08:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A11EAC4E97
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jun 2022 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654604564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVS52nKzigr/OEhjU9EY/q7WFBWsydiOGBSgOUamNK4=;
        b=Q+KTRlR+b5Ug+Ne7AbCuX6phCaTYPMEgngBxGw4JH8SrjnTfI0CBKh7YynMbQBC9kRqJH6
        8BwS/1bjkV3FBJZZgO+xZIai8Q6b0TKetDwSKbNK4XqoB3Udo2efzQ4xPDo58FedJ6LPBr
        IKURSJLBLeUsqGbMzsoisRoribygF6Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-oGXqgM0mONazNLlzRsbjNw-1; Tue, 07 Jun 2022 08:22:39 -0400
X-MC-Unique: oGXqgM0mONazNLlzRsbjNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42E093831C4D;
        Tue,  7 Jun 2022 12:22:39 +0000 (UTC)
Received: from fedora (unknown [10.40.193.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EB7DC27EA2;
        Tue,  7 Jun 2022 12:22:38 +0000 (UTC)
Date:   Tue, 7 Jun 2022 14:22:36 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix possible fs corruption due to xattr races
Message-ID: <20220607122236.3anpsbtsw3vjyuy5@fedora>
References: <20220606142215.17962-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606142215.17962-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 06, 2022 at 04:28:45PM +0200, Jan Kara wrote:
> Hello,
> 
> I've tracked down the culprit of the jbd2 assertion Ritesh reported to me. In
> the end it does not have much to do with jbd2 but rather points to a subtle
> race in xattr code between xattr block reuse and xattr block freeing that can
> result in fs corruption during journal replay. See patch 2/2 for more details.
> These patches fix the problem. I have to say I'm not too happy with the special
> mbcache interface I had to add because it just requires too deep knowledge of
> how things work internally to get things right. If you get it wrong, you'll
> have subtle races like above. But I didn't find a more transparent way to
> fix this race. If someone has ideas, suggestions are welcome!
> 
> 								Honza

I haven't give too much thought towards finding a better way to fix the
race, but this seems like ok solution to me.

You can add to the series

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

