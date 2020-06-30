Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BA20FBCD
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jun 2020 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgF3SfC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Jun 2020 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgF3SfC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Jun 2020 14:35:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7DC061755
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jun 2020 11:35:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n26so7698125ejx.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jun 2020 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYTpn9wvRdEaTRjaJdbdxVXSR0aML0y9438m1z47Nx8=;
        b=DvtCqZTfteuxeWQTQvPK01f/AGYnvT3R6qRAwVappoBWNVQZ+WO+TU5hAzZDYZIRq0
         B2Ig97evIBN87jmXhfkV8rdRJA8XNb/3xVEFyd6QJwv7MDVAwJD6+rjViKVoxOR3AdLj
         8tdiCVIndGgeSvflFSSnipr2IrIvzu5ZEn1ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYTpn9wvRdEaTRjaJdbdxVXSR0aML0y9438m1z47Nx8=;
        b=Sl+HzIXKNsxYgUk2KJOURZ+36SCBTohLBG0Jqb1fawja0qhRF0t5oJKCi/B7BMLUsb
         sZzyQ+xJ94fxfQBVJ9AmKX58XMUBuiW2nlUZ+C6oGj3vOhpLANtGdYPXEVkYViUz2zt+
         X7+Dv79YF8lU1tV3Ix/moi+KOPRCr9hCAeQgLHNTVcMkfj54/gjlmk1x3wCqkHjGImqO
         vNIbUP/a5OcGHL+Efx1gvsDn8Hnq3PIZ1W4jWYHgHuzC83VICAjPpAqTIsSqN7aJC1i/
         nZpxUliYcHGpo7HrhK5mPJBYTBYV5WisZ35oNQa9wBIdULZsikp5c/eYQfgKvqKaB6st
         vBZw==
X-Gm-Message-State: AOAM532H/Rr+QNJNyqqbVTsHf0P3EiwkzBy/2c2/tJWkqtK9x1Ai2r87
        d/sR0I0eHOluIofNRc2DacAvKtsu0jWqUwvPU8tEWQ==
X-Google-Smtp-Source: ABdhPJzH/VG0zdEWDgO7pd+Z7p7kfKoV9eWT81AaEbiHELtNCBLY9hTqOUFZ7AhW1+JRNDQIMFzXoEK9jU9Y1BCVKiw=
X-Received: by 2002:a17:906:4989:: with SMTP id p9mr20240049eju.417.1593542100329;
 Tue, 30 Jun 2020 11:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAABuPhaMHu+mmHbVKGt2L0tcE2-EMyd5VWcok7kAfJY3DQ=-vw@mail.gmail.com>
 <20200630114832.GA16372@quack2.suse.cz>
In-Reply-To: <20200630114832.GA16372@quack2.suse.cz>
From:   Costa Sapuntzakis <costa@purestorage.com>
Date:   Tue, 30 Jun 2020 11:34:49 -0700
Message-ID: <CAABuPhZrQXQ8-tFu9V3575by5N3RV7jd-OcOjy_pLw_na1OUkw@mail.gmail.com>
Subject: Re: [BUG] invalid superblock checksum possibly due to race
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello and thank you!

> Yes, probably ext4_superblock_csum_set() should use
>
> lock_buffer(EXT4_SB(sb)->s_sbh)
>
> to synchronize updating of superblock checksum. Will you send a patch?

Yes. I will send a patch.

I noticed lock_buffer can sleep. That would seem to imply to me that
lock_buffer can be held across I/Os.
I worry that this will occasionally significantly slow down this code
path compared to what it used to be.  Are there any things
about the way ext4 uses buffers that makes this less of a concern?

-Costa
