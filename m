Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7E1ABCFF
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503780AbgDPJix (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 05:38:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503578AbgDPJiv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 05:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587029929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+rqi3L5FDJqD7YQTOqV2EpVQXTH9nkPrZpkHOsY7JM=;
        b=KWuBfUSWq3LQRvNHnX9dI29xs/GALxbNPFEQJblPbVi1tAX6YsCnzo4PizzqauCsjAI6t3
        mCyIZTfWqXbHC6fF1Ox3B+J6VCGqpGtvgR9bSdwvBOV75EAOuOTQEfjplMnIWjQnGKM/Z3
        p5GSvoQqyIEi6tRluQtef7t5SwJoufQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-uGpiPWxRNdCNHcn7i7BxBw-1; Thu, 16 Apr 2020 05:38:47 -0400
X-MC-Unique: uGpiPWxRNdCNHcn7i7BxBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 972E910CE787;
        Thu, 16 Apr 2020 09:38:45 +0000 (UTC)
Received: from work (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D93E0A0997;
        Thu, 16 Apr 2020 09:38:44 +0000 (UTC)
Date:   Thu, 16 Apr 2020 11:38:40 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2scrub: Remove PATH setting from the scripts
Message-ID: <20200416093840.y5w2azeivn6mhbnu@work>
References: <20200402134716.3725-1-lczerner@redhat.com>
 <20200410161635.GP45598@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410161635.GP45598@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 10, 2020 at 12:16:35PM -0400, Theodore Y. Ts'o wrote:
> On Thu, Apr 02, 2020 at 03:47:16PM +0200, Lukas Czerner wrote:
> > We don't want to override system setting by changing the PATH. This
> > should remain under administrator/user control.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> The reason why the PATH was added is because most users don't have
> /sbin or /usr/sbin in their PATH, and if they run "sudo e2scrub",
> finding commands like lvcreate, lvremove, et. al., wouldn't be there.

I don't understand, e2scrub should be in be in sbin as well, right ?
Besides what if such user wants to run lvcreate, or lvremove ? This
seems like a problem that should be fixed somewhere else.

> 
> I suppose we could do something like
> 
> PATH=$PATH:/sbin:/usr/sbin

that's better than replacing it.

-Lukas

> 
> instead, but otherwise, users will see some unexpected failures.
> 
> 	     		      	       	    	       - Ted
> 

