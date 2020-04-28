Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1D1BC5E5
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgD1Q54 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:57:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728022AbgD1Q5z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588093074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JDIEnDACvHBkOvQ0mTswPhmJ6LMG8hCfuTi+Gx3LEzc=;
        b=MjSbHXpF+uDR4Q121Aa3rVYhZ85Sj4slUfCaTPFPLCz1m/UXZjaVh2BJ937pmKaNmac2wR
        Ya5j05bis6l/mukMK/nOwhzdiGyMIazOS6okBk7ha0BiYRefnpERTMya2ai1sGLB+LB5pD
        W50NgTSfOGyS96MTaYRjkWlD3mVOBhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-V2aKWEDzMMex6IVM5t9zyA-1; Tue, 28 Apr 2020 12:57:53 -0400
X-MC-Unique: V2aKWEDzMMex6IVM5t9zyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37812835B40;
        Tue, 28 Apr 2020 16:57:52 +0000 (UTC)
Received: from work (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C8A510013BD;
        Tue, 28 Apr 2020 16:57:50 +0000 (UTC)
Date:   Tue, 28 Apr 2020 18:57:47 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
Message-ID: <20200428165747.ondq7nbn4ol3j3lu@work>
References: <20200428164536.462-1-lczerner@redhat.com>
 <20200428164536.462-6-lczerner@redhat.com>
 <20200428164808.GA3632@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164808.GA3632@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 09:48:08AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 06:45:24PM +0200, Lukas Czerner wrote:
> > At the parsing phase of mount in the new mount api sb will not be
> > available so allow sb to be NULL in ext4_msg and use that in
> > handle_mount_opt().
> > 
> > Also change return value to appropriate -EINVAL where needed.
> 
> Shouldn't mount-time messages be reported using the logfc and family
> helpers from include/linux/fs_context.h? (which btw, have really
> horrible over-generic names).

I am sure it should at some point, but I am not really sure how ready
it is at the moment. Last time I checked David told me not to bother
using it yet.

Is it ready yet David ? Should we be switching to it ?

-Lukas

