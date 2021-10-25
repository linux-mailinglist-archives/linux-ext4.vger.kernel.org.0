Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128B94392E3
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhJYJpY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 05:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232932AbhJYJoz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Oct 2021 05:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635154953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=COwhU8u1EDC/u2j+9kVyks8op8zN2wnk/oMkLD2BQEg=;
        b=Tnay5KeM0JhQkeDYqKT8xnJcPheH7u4cmcJiHrK7OMj/xLHcUqfx7mpwPAXT1hB7vYyyvo
        HbAHAjT//xHgFnvWa+ROfTYhOXHSgc3wfZy+UI+342BHwwJ0KlxpfPau2m6QVpY06UVBbK
        K0/nq5XI0MkKZyaUpgH+ZBXzL88ht9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-rcLlsbI0OgyXsQCGLCrKIg-1; Mon, 25 Oct 2021 05:42:31 -0400
X-MC-Unique: rcLlsbI0OgyXsQCGLCrKIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F4F18125C0;
        Mon, 25 Oct 2021 09:42:30 +0000 (UTC)
Received: from work (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A379D1948C;
        Mon, 25 Oct 2021 09:42:29 +0000 (UTC)
Date:   Mon, 25 Oct 2021 11:42:27 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Laurent GUERBY <laurent@guerby.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: How to force EXT4_MB_GRP_CLEAR_TRIMMED on a live ext4?
Message-ID: <20211025094227.yio3cjpboxumt5ml@work>
References: <1634984680.26818.10.camel@guerby.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1634984680.26818.10.camel@guerby.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 23, 2021 at 12:24:40PM +0200, Laurent GUERBY wrote:
> Hi,
> 
> When using fstrim on an ext4 filesystem trim are not issued for
> EXT4_MB_GRP_WAS_TRIMMED space which is a useful optimization.
> 
> Is there a way to force a complete trim on a mounted ext4 filesystem? 
> 
> My (limited) understanding of the code is that
> EXT4_MB_GRP_CLEAR_TRIMMED should be called to do so.
> 
> My use case is having live migrated a virtual machine root disk from
> one storage to another, the target supporting trim, but since fstrim in
> the VM post migration does mostly nothing (assumes most space was
> trimmed) I cannot release space to the new storage.

Hi,

interesting. I don't think this scenario was ever considered so no,
there is no way to bypass the optimization other than just unmount and
mount the file system again, which I can understand is inconvenient for
root file system ;)


> 
> I tried mount -o remount but without effect. e2fsprogs don't seem to
> have an option/tool to do this either.
> 
> I've seen suggestion that rebooting will do the job but the whole point
> of live migration is to avoid reboot :).
> 
> I did end up creating dummy files to fill the filesystem and then
> removing them, but this is far less efficient than what a filesystem
> tool could do.

Yeah, that's bad. The information is stored in the buddy cache in memory
and AFAIK is only dropped on unmount. I'll have to think about how to
clear either the cache or selectively just the flag.

What would be more convenient way of doing this for you, -o remount, or
using let's say tune2fs ? I am not promising anything yet, but I'll think
about how to implement it.


Meanwhile other than umount/mount, or actually writing to the dummy files,
you can try to use fallocate to allocate all the remaining space in the
file system and subsequently removing it. That should be more efficient,
but don't forget to sync after remove to make sure the space is released
before you call fstrim.

You could also force fsck on ro file system and use -E discard to trim the
free space but I can't say I recommend it.

-Lukas

> 
> Thanks in advance for your help,
> 
> Sincerely,
> 
> Laurent
> 

