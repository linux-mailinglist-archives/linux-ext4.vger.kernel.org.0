Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20829EB794
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 19:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfJaSxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 14:53:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35745 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJaSxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Oct 2019 14:53:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id c8so4643913pgb.2
        for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2019 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vAl3YvHSNTRduhIM26AVCJ75hPpo2VYH4I4XOsjkW2s=;
        b=p7/8o2QONt+9NppvWXpOmh07JTPm3bIPBotn5wFQ+/40mdlmJsrSydnxXOsRwqEYkf
         dN4lkvjnXtoiB83XrpWaUh19y2bi4iEbcDQQ6tkusm+FwoU7Iqv+JubGTXOPsc2r3K45
         yZury3n4EXrtmH/sudr7A5Gcfh79hk1EKndA+1yTXDak7rlrwllFcn/eo7ayZfyUS3gl
         lXMrXnI0dmMvwLLr9fx/82zvd7YDXsgtIzxugyxocDCPsSD/gbHYh37mm2UE/99e5IZ4
         KnzGLRgR1B9jiWRQ0+osIz+zC6cD+V6jcgAwtPCkmj1BdA9P5d/1Rwz9qoacm9bGjE1F
         dUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vAl3YvHSNTRduhIM26AVCJ75hPpo2VYH4I4XOsjkW2s=;
        b=XR0/A6H70+Pxhx4qLffdwkZaLyA330/qHSFxMpN0ifXrnxJkTXrTIwsOgjYP6iBOdA
         gUL51FjUsWC6UUpTTAGFMcT0GdIAabtRu0y51xQQMMBHpl5QMkAWXetGQsJsjwA4bEYU
         vQ7j6w1eqr1pYxJOf7iclauGadTzz4z3nEhDkry/kJYo+ilpmZrM+BvrVnVt2kbpweCP
         m82FGivYodKMvNdIKxhJmPcum6riW4L9WpCveml/b6qnDr7liW65R1kHohQY8f8DszKY
         ivdByAUPRYgZnzd2YzkD4j9zMFoub5K3o5j3B2KV8Zrv6JZWFZ+sFPHX8YWhfJUYA97q
         zlLg==
X-Gm-Message-State: APjAAAXzhcXGixsASJqMzNH2pm3W1uQgSyaEqARr7s1yRRKtdMGt6cUy
        DIpRK9zMyqXEw/5OUmHcqI+I2g==
X-Google-Smtp-Source: APXvYqw1vd2VThqWOI6cfiNWdnLNLwXzigkRBZe/hSb/eG9yzXFyTDSmXsonYi+zBD3F9M0FF7/erg==
X-Received: by 2002:a63:e057:: with SMTP id n23mr8128503pgj.94.1572547993801;
        Thu, 31 Oct 2019 11:53:13 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c62sm3968669pfa.92.2019.10.31.11.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 11:53:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9DF0D322-3ACC-4094-976B-CF8F4A06F655@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B928C721-DD8B-4C60-852E-D1C709CCBE81";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 12/13] docs: Add fast commit documentation
Date:   Thu, 31 Oct 2019 12:53:10 -0600
In-Reply-To: <20191018132802.GE21137@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
To:     "Theodore Y. Ts'o" <tytso@MIT.EDU>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-13-harshadshirwadkar@gmail.com>
 <20191018015655.GB21137@mit.edu>
 <C41A9852-DFA0-4F1A-A984-29A71D23CEFB@dilger.ca>
 <20191018132802.GE21137@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B928C721-DD8B-4C60-852E-D1C709CCBE81
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 18, 2019, at 7:28 AM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> 
> On Fri, Oct 18, 2019 at 01:51:56PM +0900, Andreas Dilger wrote:
>> What about rename or hard link?
> 
> Neither is currently handled by the fast commit patches, but each
> operation can fit inside a single block, so it could be handled as a
> update to a single inode.  In the case of rename, we will need to add
> some tags to indicate the desintation directory and directory enrty
> name, and whether or not there is a destination inode which needs to
> have its refcount dropped and possibly deleted.
> 
> Harshad, we probably should handle them, since in order to support
> NFS, the nfs server will send the rename or hard link request,
> followed by a commit metadata request, and that commit metadata
> request needs to persist the rename or link.  So for the purposes of
> accelerating NFS, we should handle these commands.
> 
> If we don't handle these commands, we will need to declare the inode
> as fast commit ineligible, so that we force a full journal commit when
> the commit metadata request is received.

As a simplifying assumption, you could limit the case of rename/link
within a single directory?  That handles the common case of "create
temp file, write contents there, sync, rename over original file"
used by most editors, rsync, etc.  The case of cross-directory rename
is much less common in my experience, so it is less important to
optimize that case (if this makes it easier to add to fast commits).

Cheers, Andreas






--Apple-Mail=_B928C721-DD8B-4C60-852E-D1C709CCBE81
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl27LZcACgkQcqXauRfM
H+D44hAAoTKmjUc4N0n9pXHkO8qOxdp/RR/RNUIiqN9nVaS3vH4hKOCtlOJ/B07o
RXVR7CLeDbg2hShb6stnoVoVAPlTowr13QK9cx0OMg6agecENSKWL2EQYPNNwgba
BO+ryYpSr0t3UNMXPvWV2dmVswmwD4CxZZoLp8fZkbhAcUStUlzF9v3XPTG9UcyZ
OGpsFYAnQTEltFBDGFITsMwz922HFNA9T+pRmwGNTBrdOExtTtAhVKlyx4i3GaLi
tr2jzLWPqfgMsmucz8h3q4Vw6F08SLgiqJt3vOzfTg4DaGgm3wwuu3IUeZL4Vutf
ulQ02oqEaZWby1I7DM5DbXhetrPqt62Xv/sWsQcTFp/WGR3DW0wwj9lzt2nfgR47
dQzTJWVPWEAuhpFTC1Qgfya+tiAKSD7ZtPp/x0LkumNvS4S/56SiC8MlAKaljQYU
FgKpFt0sftZhutqo+T92GJTQf1ST7fyNBZ5qvT7LNGZJUyRbnXtnYAV4U69tX2e/
iPhFshF5Fkvbwon2Po2Q5Hw1GSeXmTAhAKT8w+sK/IUr9n8Qdoa1885YKWhT6p6Z
p6Vekk2zmM4AgW9idLOKYvhMx+06UZ+UH6eB0lP4azu7+WzCjDQm75r/hQzP1ugr
gUbJZJwMsU0YIFxXqTQ9+ebntPSbb5QNuZfs5zRAo/eu3S50eWg=
=PcEO
-----END PGP SIGNATURE-----

--Apple-Mail=_B928C721-DD8B-4C60-852E-D1C709CCBE81--
