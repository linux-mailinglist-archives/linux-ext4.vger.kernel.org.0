Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F844119DC
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Sep 2021 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhITQfS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Sep 2021 12:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhITQfR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Sep 2021 12:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632155630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eofAwNSQHggES8FnoNdSbxlwsVv5uIPZtDIw746OjHo=;
        b=RE5ikbAjfJxkCve1XzNDlipsl/JONa5BluAFeHFOoEUr0tLGrfCOG5lKYRYZahYu2b3BTM
        eTwlNT+UxM4AZJZaVjM1JAL2V4BtEg6iC2RQmHSH2106PfBKhcbQ/cUsIlivIrEj4JSQeC
        qLZP6MnyalF07Lcg5CRJCIa0WwHOI+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-lviKKn19PQC-tNZukbZv5w-1; Mon, 20 Sep 2021 12:33:48 -0400
X-MC-Unique: lviKKn19PQC-tNZukbZv5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3AD1100D68E;
        Mon, 20 Sep 2021 16:33:27 +0000 (UTC)
Received: from localhost (unknown [10.39.194.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2D46B545;
        Mon, 20 Sep 2021 16:33:27 +0000 (UTC)
Date:   Mon, 20 Sep 2021 17:33:26 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, Eric Blake <eblake@redhat.com>,
        linux-ext4@vger.kernel.org, libguestfs@redhat.com,
        lersek@redhat.com
Subject: Re: e2fsprogs concurrency questions
Message-ID: <20210920163326.GA16016@redhat.com>
References: <YUazQg9TtlZZm10H@mit.edu>
 <24A05FA3-F618-4469-BC0A-E19A425A0E36@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24A05FA3-F618-4469-BC0A-E19A425A0E36@dilger.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 19, 2021 at 04:39:01AM -0600, Andreas Dilger wrote:
> What I don't understand here is why not just use a network
> filesystem that is explicitly designed for this task (eg. NFS or
> Ganesha on to of ext4)?

nbdkit-ext2-filter is very niche, but it's quite different from
anything NFS can do.  For example:

  $ nbdkit --filter=ext2 --filter=xz \
    	 curl http://oirase.annexia.org/tmp/disk.img.xz \
  	      ext2file=/disk/fedora-33.img

  $ nbdinfo nbd://localhost
  protocol: newstyle-fixed without TLS
  export="":
  	export-size: 6442450944
  	content: DOS/MBR boot sector
  	uri: nbd://localhost:10809/
  	contexts:
  		base:allocation
  		is_rotational: false
  		is_read_only: true
  		can_cache: true
  		can_df: true
  		can_fast_zero: false
  		can_flush: true
  		can_fua: false
  		can_multi_conn: false
  		can_trim: false
		can_zero: false

  $ guestfish --ro --format=raw -a nbd://localhost -i
  [...]
  Operating system: Fedora 33 (Thirty Three)
  /dev/sda3 mounted on /
  /dev/sda2 mounted on /boot

What we're doing here is exporting a compressed ext4 image over HTTP
and then accessing a VM image inside it.

(This is a contrived example but it's similar to something called the
Containerized Data Importer in Kubernetes.)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

