Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3AB210FF8
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jul 2020 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgGAQAm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jul 2020 12:00:42 -0400
Received: from mail-m963.mail.126.com ([123.126.96.3]:46562 "EHLO
        mail-m963.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgGAQAm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jul 2020 12:00:42 -0400
X-Greylist: delayed 2045 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 12:00:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Mime-Version:Subject:Date:Message-Id; bh=YtI0P
        jwSImHQKIG3jnrVB1ROff2uxyWiSvrsNWvn+Rg=; b=aJ0HmFAxz5jORv8XYWNWM
        NbIeSLd1ZHU4OvsXwyQ15uAhta6fF1TIe+8Kg0EdOgbWnhBJQn3ZziVzLCpRl1XN
        pC2zdCQvPsgk71ToazRIrclS/6WLtsRc5pltIMw85E3QwzzVti2DxGy/y96uXoGb
        DZcavrFMl+OXkonH/vmjtM=
Received: from [192.168.199.244] (unknown [61.149.189.172])
        by smtp8 (Coremail) with SMTP id NORpCgAXJaHnqvxeOrAUCw--.6437S2;
        Wed, 01 Jul 2020 23:25:28 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?B?5aec6L+O?= <jiangying8582@126.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] ext4: fix direct I/O read error
Date:   Wed, 1 Jul 2020 23:25:26 +0800
Message-Id: <13A548B3-C71D-4637-B194-CC405991AFC4@126.com>
References: <1593423930-5576-1-git-send-email-jiangying8582@126.com>
In-Reply-To: <1593423930-5576-1-git-send-email-jiangying8582@126.com>
To:     Markus.Elfring@web.de, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanglong19@meituan.com, heguanjun@meituan.com
X-Mailer: iPhone Mail (17F80)
X-CM-TRANSID: NORpCgAXJaHnqvxeOrAUCw--.6437S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW8JFW5WFWrtw1rGw15Jwb_yoWrAr4kpr
        sxCa15Wrs5Xr1xCan2g3Wj9a4Fy3yDGFWUXryY9347AwnIgFnYgFWxKFnrG3yUGrW09a1F
        qFZ8tryfAw1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U85rxUUUUU=
X-Originating-IP: [61.149.189.172]
X-CM-SenderInfo: xmld0wp1lqwmqvysqiyswou0bp/1tbirwlUAFpD91fGbgAAsj
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Does anyone else have any comments on the PATCH v3=EF=BC=9FSuggestions are w=
elcome.

Thanks=EF=BC=81

=E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84iPhone

> =E5=9C=A8 2020=E5=B9=B46=E6=9C=8829=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=885:4=
5=EF=BC=8CJiang Ying <jiangying8582@126.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFThis patch is used to fix ext4 direct I/O read error when
> the read size is not aligned with block size.
>=20
> Then, I will use a test to explain the error.
>=20
> (1) Make a file that is not aligned with block size:
>    $dd if=3D/dev/zero of=3D./test.jar bs=3D1000 count=3D3
>=20
> (2) I wrote a source file named "direct_io_read_file.c" as following:
>=20
>    #include <stdio.h>
>    #include <stdlib.h>
>    #include <unistd.h>
>    #include <sys/file.h>
>    #include <sys/types.h>
>    #include <sys/stat.h>
>    #include <string.h>
>    #define BUF_SIZE 1024
>=20
>    int main()
>    {
>        int fd;
>        int ret;
>=20
>        unsigned char *buf;
>        ret =3D posix_memalign((void **)&buf, 512, BUF_SIZE);
>        if (ret) {
>            perror("posix_memalign failed");
>            exit(1);
>        }
>        fd =3D open("./test.jar", O_RDONLY | O_DIRECT, 0755);
>        if (fd < 0){
>            perror("open ./test.jar failed");
>            exit(1);
>        }
>=20
>        do {
>            ret =3D read(fd, buf, BUF_SIZE);
>            printf("ret=3D%d\n",ret);
>            if (ret < 0) {
>                perror("write test.jar failed");
>            }
>        } while (ret > 0);
>=20
>        free(buf);
>        close(fd);
>    }
>=20
> (3) Compile the source file:
>    $gcc direct_io_read_file.c -D_GNU_SOURCE
>=20
> (4) Run the test program:
>    $./a.out
>=20
>    The result is as following:
>    ret=3D1024
>    ret=3D1024
>    ret=3D952
>    ret=3D-1
>    write test.jar failed: Invalid argument.
>=20
> I have tested this program on XFS filesystem, XFS does not have
> this problem, because XFS use iomap_dio_rw() to do direct I/O
> read. And the comparing between read offset and file size is done
> in iomap_dio_rw(), the code is as following:
>=20
>    if (pos < size) {
>        retval =3D filemap_write_and_wait_range(mapping, pos,
>                pos + iov_length(iov, nr_segs) - 1);
>=20
>        if (!retval) {
>            retval =3D mapping->a_ops->direct_IO(READ, iocb,
>                        iov, pos, nr_segs);
>        }
>        ...
>    }
>=20
> ...only when "pos < size", direct I/O can be done, or 0 will be return.
>=20
> I have tested the fix patch on Ext4, it is up to the mustard of
> EINVAL in man2(read) as following:
>    #include <unistd.h>
>    ssize_t read(int fd, void *buf, size_t count);
>=20
>    EINVAL
>        fd is attached to an object which is unsuitable for reading;
>        or the file was opened with the O_DIRECT flag, and either the
>        address specified in buf, the value specified in count, or the
>        current file offset is not suitably aligned.
>=20
> So I think this patch can be applied to fix ext4 direct I/O error.
>=20
> However Ext4 introduces direct I/O read using iomap infrastructure
> on kernel 5.5, the patch is commit <b1b4705d54ab>
> ("ext4: introduce direct I/O read using iomap infrastructure"),
> then Ext4 will be the same as XFS, they all use iomap_dio_rw() to do direc=
t
> I/O read. So this problem does not exist on kernel 5.5 for Ext4.
>=20
> =46rom above description, we can see this problem exists on all the kernel=

> versions between kernel 3.14 and kernel 5.4. Please apply this patch
> on these kernel versions, or please use the method on kernel 5.5 to fix
> this problem.
>=20
> Fixes: 9fe55eea7e4b ("Fix race when checking i_size on direct i/o read")
> Co-developed-by: Wang Long <wanglong19@meituan.com>
> Signed-off-by: Wang Long <wanglong19@meituan.com>
> Signed-off-by: Jiang Ying <jiangying8582@126.com>
>=20
> Changes since V2:
>    Optimize the description of the commit message and make a variation for=

>    the patch, e.g. with:
>=20
>        Before:
>            loff_t size;
>            size =3D i_size_read(inode);
>        After:
>            loff_t size =3D i_size_read(inode);
>=20
> Changes since V1:
>    Signed-off use real name and add "Fixes:" flag
>=20
> ---
> fs/ext4/inode.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa2..a66b0ac 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3821,6 +3821,11 @@ static ssize_t ext4_direct_IO_read(struct kiocb *io=
cb, struct iov_iter *iter)
>    struct inode *inode =3D mapping->host;
>    size_t count =3D iov_iter_count(iter);
>    ssize_t ret;
> +    loff_t offset =3D iocb->ki_pos;
> +    loff_t size =3D i_size_read(inode);
> +
> +    if (offset >=3D size)
> +        return 0;
>=20
>    /*
>     * Shared inode_lock is enough for us - it protects against concurrent
> --=20
> 1.8.3.1

