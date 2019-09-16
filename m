Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11B6B4495
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 01:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfIPX3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 19:29:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIPX3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 19:29:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so1139159wrx.5;
        Mon, 16 Sep 2019 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iSJV746RJhhQqjkMYfS7cXLz5TDKUWbV61EOzvKoZE8=;
        b=sOnrCysgB8VpJ/0LmxZjUQaJw6293vaRqOVGY7iS9Cv094eZlzG1ZltkyhgHGXFpdr
         5gjvtVHKucXlUlGU6uJOAN0f9W/ohCedq6jOQ1cPuXzdjtnXrGq34cgOOzp//emRFqvL
         eR4ssAYDx0jRGQZBphzPZcodGYS9OJnLMDO/d3HFYzhjQsb19BDY5Ndq1gGoDXDrjjRg
         47qMYNwRzx3X7vssqRebmiWmUHYaxdx8QB2h/kspujtbXAe/5VdyZ6Ce23tLymJqPo5w
         HNdS5TpT42UOPIN7sIn31dGr2tWYF4Noa8UwBpmQAx4EcThMrhI6JiyxyOMzGheQKC51
         +cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSJV746RJhhQqjkMYfS7cXLz5TDKUWbV61EOzvKoZE8=;
        b=i8IV61L3VD4UMOGLIa2nhAcq2/0bXNr2NS2GjxzUot7GK0V9mlwo1G4pDhGfgwjCee
         3N32RFc5/jbnYQO6VxvlZMdCiUrwaTRGEbJvmo7erBuNrzaIP92agdZgNIsz6sfUPkPC
         /1bPpvTb5ZnVzQCQlIcPYiqJwX51cRnmg5jsG/Mnb/x8jqhMwmqxr+aHasTcbqD6GN+Y
         1I26RGIKOvhkzzINv4jOJo5o5ZKP2hGyWWmyNx0h7TsPznwb5+HUwYFnmw4qTKwVa3Uu
         aSYZKbsCaC3FTk671gQAS0wRvvenLaYu1CKpa52C6QjDqHE9tHqKUzMFSeLdstxT0DJP
         DgMw==
X-Gm-Message-State: APjAAAXb7LmE2I8zNaLEwOuVlYuu8js+BZ+1nU8eF8et7f18KDXC3tfB
        dbsezrPyad17TMJcAdnG5yE=
X-Google-Smtp-Source: APXvYqyxDwVFzcE3x/4xdXPW2m8KVSDpMzJvReZW6zi2IZkcFBIXoMH+4N1RbVOHMezJ68DhsuBA6Q==
X-Received: by 2002:adf:f112:: with SMTP id r18mr632122wro.88.1568676571199;
        Mon, 16 Sep 2019 16:29:31 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-3-39.web.vodafone.de. [109.42.3.39])
        by smtp.gmail.com with ESMTPSA id f3sm317963wrq.53.2019.09.16.16.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 16:29:30 -0700 (PDT)
Date:   Tue, 17 Sep 2019 01:29:22 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190916232922.GA7880@darwi-home-pc>
References: <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
 <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
 <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org>
 <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 04:18:00PM -0700, Linus Torvalds wrote:
> On Mon, Sep 16, 2019 at 4:11 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > In one case we have "Systems don't boot, but you can downgrade your
> > kernel" and in the other case we have "Your cryptographic keys are weak
> > and you have no way of knowing unless you read dmesg", and I think
> > causing boot problems is the better outcome here.
> 
> Or: In one case you have a real and present problem. In the other
> case, people are talking hypotheticals.
>

Linus, in all honesty, the other case is _not_ a hypothetical . For
example, here is a fresh comment on LWN from gnupg developers:

    https://lwn.net/Articles/799352

It's about this libgnupg code:

    => https://dev.gnupg.org/source/libgcrypt.git

    => random/rdlinux.c:
    
    /* If we have a modern operating system, we first try to use the new
     * getentropy function.  That call guarantees that the kernel's
     * RNG has been properly seeded before returning any data.  This
     * is different from /dev/urandom which may, due to its
     * non-blocking semantics, return data even if the kernel has
     * not been properly seeded.  And it differs from /dev/random by never
     * blocking once the kernel is seeded.  */
    #if defined(HAVE_GETENTROPY) || defined(__NR_getrandom)
    do {
        ...
        ret = getentropy (buffer, nbytes);
        ...
    } while (ret == -1 && errno == EINTR);

thanks,

-- 
Ahmed Darwish
http://darwish.chasingpointers.com
