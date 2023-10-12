Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9457C74E1
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347382AbjJLRg4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbjJLRgo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 13:36:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731D72B8
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 10:28:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-200.bstnma.fios.verizon.net [173.48.111.200])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39CHSZfw010290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 13:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1697131717; bh=Mj61PG0B6JCZm64HAIUt9iikTAptSWgh2LMnRY4Oq1I=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=KiaoRoH5DJ5UyK8zHCg9jW72HJJ1DRK02hF/21ey+FZNRgH3y11D/8G00RRIGK8Ka
         +shSqVo7jQtfrC8So6nuyjo7FXSSfM/ETd5FFhApwomxZ+YlwQetoP1Pv+A3swlaB1
         Pm9wGYw0fwi0OvH0ALDACpinQD4YmI/kERuXmNeans+YSgsIoi3Ko0XKA6Pk9GkH6G
         rrEl6R8oddqN3NYYWVjK6CpSxR2hi7p62MgrHs6tJemkx+PevSxdxZKp5Pm5uNxu0r
         REZPaz0+im2i1BduPPfYrgraJY7yzGmPNF+7Ba8Q/do4ZG1yGX2V8I6kPyvY9weGmW
         /JmsielZyQONQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B35715C0255; Thu, 12 Oct 2023 13:28:35 -0400 (EDT)
Date:   Thu, 12 Oct 2023 13:28:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH 1/2] kvm-xfstests: install-kconfig: Use $ARCH-config
 instead of $KERN_ARCH-config
Message-ID: <20231012172835.GD255452@mit.edu>
References: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 12:46:30AM +0530, Ritesh Harjani (IBM) wrote:
> $KERN_ARCH is used for make arguments. For configs let's use
> $ARCH-config. This should not break anything since as of now we only
> have arm64-config for which $ARCH and $KERN_ARCH is same.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

It would be much better to teach set_canoncalized_arch about the
powerpc64le architecture.  That way other scripts that use
set_canoicalized_arch can correctly depend on KERN_ARCH.  See
run-fstests/util/arch_funcs:

# There are multiple ways that CPU architectured can be named.
# KERN_ARCH is what is used when specifying ARCH=xxx when building the
# kernel.
#
# GCE_ARCH is what gets used when setting specifying the architecture
# when creating the GCE image using the --architecture flag
# ARCH (after being canonicalized by this function) is defined by
# the Debian architecture port names[1] and is used internally
# by gce-xfstests and kvm-xfstests.  So for example, when we add
# support for support for Power architectures, the ARCH name that should
# be used is ppc64 or ppc64el.

...

# This function takes as input a user-supplied architecture (which
# generally should be a Debian port name, but users might use
# a $(uname -m) instead.
#
function set_canonicalized_arch () {
    case "$1" in
	arm64|aarch64)
	    ARCH="arm64"
	    GCE_ARCH="ARM64"
	    KERN_ARCH="arm64"
	    ;;
    ...

So basically, after calling set_canoncalized_arch, ARCH should be
Debian architecture port name, GCE_ARCH (if not the empty string) is
the name of the GCE architecture name, and KERN_ARCH should be what
should be passed to the Kernel makefile as "make ARCH=$KERN_ARCH ..."

       	  	    	       		- Ted
