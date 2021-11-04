Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F26445086
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKDIqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 04:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhKDIqE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636015406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVsFFEpnmiUO7LTjJRoivd4npSADh5xncUE4LYckSXM=;
        b=Wiwt6cCzlnKZFfzx5yFHJEb16fvtwd1Ibm+HTBkZ0a4/An+mDAkB4kdV+V8IPE7M5svTlf
        YIuIAxhyxtJGamK3ytK2m9kO+5+BZSh8taYT3yqnOKBRmdWZYhLeYq+C0S+J+4B7rN4h4k
        UvevJXL15q+ZW7pd9I6TG0iAQxgkdOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Lz4xWKAUMwGZ1x4EYPEQbA-1; Thu, 04 Nov 2021 04:43:23 -0400
X-MC-Unique: Lz4xWKAUMwGZ1x4EYPEQbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBBDF8066F0;
        Thu,  4 Nov 2021 08:43:20 +0000 (UTC)
Received: from work (unknown [10.40.194.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9257C18351;
        Thu,  4 Nov 2021 08:43:19 +0000 (UTC)
Date:   Thu, 4 Nov 2021 09:43:15 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v4] ext4: add test for all ext4/ext3/ext2 mount options
Message-ID: <20211104084315.qvmuy5bf4tzd56op@work>
References: <20211026093112.26221-1-lczerner@redhat.com>
 <20211102105911.5790-1-lczerner@redhat.com>
 <YYNUfvH52COSOnai@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYNUfvH52COSOnai@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 03, 2021 at 11:33:18PM -0400, Theodore Ts'o wrote:
> > +_has_kernel_config()
> > +{
> > +	option=$1
> > +	config="/lib/modules/$(uname -r)/build/.config"
> > +	grep -qE "^${option}=[my]" $config
> > +}
> 
> In my test infrastructure, /lib/modules/$Kver/build/.config doesn't
> exist.  That's because I build the kernel without any modules, and
> then launch kvm using its --kernel command-line option.  This really
> helps with development velocity, since the developer doesn't need to
> waste time installing the kernel, and/or building a kernel rpm or
> dpkg.  Instead, kvm can just launch the kernel directly out of the
> build tree:
> 
> /usr/bin/kvm ... --kernel /build/ext4/arch/x86/boot/bzImage ..
> 
> So it would be nice if _has_kernel_config also checks to see if
> /proc/config.gz exists, and if so, tries to use it.

Good point. Of course it would only work if kernel is configured to have
/proc/config.gz, but I don't know of any other reliable way to checking
the kernel config.

Thanks!
-Lukas

> 
> Thanks,
> 
> 			       	   	 - Ted
> 

