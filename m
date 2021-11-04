Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC7444DBB
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 04:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDDgH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 23:36:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47258 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229893AbhKDDgH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 23:36:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A43XJoT005642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Nov 2021 23:33:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C744C15C00B9; Wed,  3 Nov 2021 23:33:18 -0400 (EDT)
Date:   Wed, 3 Nov 2021 23:33:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v4] ext4: add test for all ext4/ext3/ext2 mount options
Message-ID: <YYNUfvH52COSOnai@mit.edu>
References: <20211026093112.26221-1-lczerner@redhat.com>
 <20211102105911.5790-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102105911.5790-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> +_has_kernel_config()
> +{
> +	option=$1
> +	config="/lib/modules/$(uname -r)/build/.config"
> +	grep -qE "^${option}=[my]" $config
> +}

In my test infrastructure, /lib/modules/$Kver/build/.config doesn't
exist.  That's because I build the kernel without any modules, and
then launch kvm using its --kernel command-line option.  This really
helps with development velocity, since the developer doesn't need to
waste time installing the kernel, and/or building a kernel rpm or
dpkg.  Instead, kvm can just launch the kernel directly out of the
build tree:

/usr/bin/kvm ... --kernel /build/ext4/arch/x86/boot/bzImage ..

So it would be nice if _has_kernel_config also checks to see if
/proc/config.gz exists, and if so, tries to use it.

Thanks,

			       	   	 - Ted
